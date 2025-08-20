class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ destroy toggle ]

  def index
    @quests = Quest.all.order(:created_at)
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        @quests = Quest.all.order(:created_at)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("quests-container", partial: "quests_container"),
            turbo_stream.replace("new_quest", partial: "form", locals: { quest: Quest.new })
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_quest", partial: "form", locals: { quest: @quest })
        end
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.turbo_stream do
        @quests = Quest.all # โหลดข้อมูลใหม่หลังลบ
        render turbo_stream: turbo_stream.replace("quests-container", partial: "quests_container")
      end
      format.html { redirect_to root_path }
    end
  end

  def toggle
    @quest.update(status: !@quest.status)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path }
    end
  end

  private
    def set_quest
      @quest = Quest.find(params[:id])
    end

    def quest_params
      params.require(:quest).permit(:name, :status)
    end
end
