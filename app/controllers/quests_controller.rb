class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show destroy toggle ]

  def index
    @quests = Quest.all.order(created_at: :desc)
  @quest = Quest.new unless @quest.present?
  end

  def show
    redirect_to root_path
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        @quests = Quest.all.order(created_at: :desc)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("quests-container", partial: "quests_container"),
            turbo_stream.replace("new_quest", partial: "form", locals: { quest: Quest.new }),
            turbo_stream.remove("error_explanation")
          ]
        end
        format.html { redirect_to quests_path, notice: "Quest was successfully created." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_quest", partial: "form", locals: { quest: @quest })
        end
        @quests = Quest.all.order(created_at: :desc) # Ensure @quests is set for HTML response
        format.html { render :index, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.turbo_stream { turbo_stream.remove @quest }
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
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Quest not found."
    end

    def quest_params
      params.require(:quest).permit(:name, :status)
    end
end
