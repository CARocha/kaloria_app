class HomeController < ApplicationController
  def index
  end
  def dashboard
    #auth = params[:auth_code]
    #puts auth
    #puts '*******************'
    @user = current_user
    @data = [
      {name: "calories_ingested", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: current_user.id).sum(:calories_ingested)},
      {name: "calories_burned", data: Calory.unscoped.group_by_day(:date, range: 4.weeks.ago.midnight..Time.now).where(user_id: current_user.id).sum(:calories_burned)}
    ]
  end
  def documentation
  end
end
