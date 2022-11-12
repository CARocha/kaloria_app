class CaloriesController < ApplicationController
  before_action :set_calory, only: %i[ show edit update destroy ]

  # GET /calories or /calories.json
  def index
    if user_signed_in?
      if !params[:comment].blank? || (!params[:date_start].blank? && !params[:date_end].blank?)
        puts 'entroooo'
        @calories = Calory.where(user_id: current_user.id)
        if !params[:comment].blank?
          @calories = @calories.where("comment like ?","%#{params[:comment]}%")
        end
        if !params[:date_start].blank? && !params[:date_end].blank?
          @calories = @calories.created_between(params[:date_start], params[:date_end])
        end
        @calories = @calories.page params[:page]
      else
        @calories = Calory.where(user_id: current_user.id).page params[:page]
      end
    else
      redirect_to user_session_path
    end
  end

  # GET /calories/1 or /calories/1.json
  def show
  end

  # GET /calories/new
  def new
    if user_signed_in?
      @calory = Calory.new
    else
      redirect_to user_session_path
    end
  end

  # GET /calories/1/edit
  def edit
  end

  # POST /calories or /calories.json
  def create
    @calory = Calory.new(calory_params)

    respond_to do |format|
      if @calory.save
        format.html { redirect_to calory_url(@calory), notice: "Calory was successfully created." }
        format.json { render :show, status: :created, location: @calory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calories/1 or /calories/1.json
  def update
    respond_to do |format|
      if @calory.update(calory_params)
        format.html { redirect_to calory_url(@calory), notice: "Calory was successfully updated." }
        format.json { render :show, status: :ok, location: @calory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calories/1 or /calories/1.json
  def destroy
    @calory.destroy

    respond_to do |format|
      format.html { redirect_to calories_url, notice: "Calory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calory
      @calory = Calory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calory_params
      params.require(:calory).permit(:calories_ingested, :calories_burned, :comment, :date, :user_id)
    end
end
