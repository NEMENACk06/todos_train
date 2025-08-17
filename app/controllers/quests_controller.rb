# app/controllers/quests_controller.rb
class QuestsController < ApplicationController
  def index
    @quest  = Quest.new
    @quests = Quest.order(created_at: :desc)
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to quests_path, notice: "Created" }
      end
    else
      @quests = Quest.order(created_at: :desc)
      respond_to do |format|
        # ถ้าอยากคง error ในฟอร์มไว้
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_quest_form",
            partial: "quests/form",
            locals: { quest: @quest }
          )
        end
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    @quest = Quest.find(params[:id])
    if @quest.update(quest_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to quests_path }
      end
    end
  end

  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path }
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:name, :is_done)
  end
end
