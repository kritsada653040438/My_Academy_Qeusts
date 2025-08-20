class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ destroy toggle ]

  def index
    @quests = Quest.all
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.turbo_stream
        format.html { redirect_to quests_path, notice: "Quest was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path, notice: "Quest was successfully destroyed." }
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
