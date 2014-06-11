class NumbersController < ApplicationController
  before_action :set_number, only: [:show, :edit, :update, :destroy]

  # GET /numbers
  # GET /numbers.json
  def index
    @user=User.find(session[:user_id])
    @app = @user.apps.find(params[:app_id])
    ApplicationHelper.readHeader params[:app_id]
  end


# GET /numbers/1
# GET /numbers/1.json
  def show
  end

# GET /numbers/new
  def new
    @number = Number.new
  end

# GET /numbers/1/edit
  def edit
  end

# POST /numbers
# POST /numbers.json
  def create
    @number = Number.new(number_params)
    @number.app_id = params[:number][:app_id]
    respond_to do |format|
      if @number.save
        format.html { redirect_to numbers_path(:app_id => @number.app_id), notice: 'Number was successfully created.' }
        format.json { render :show, status: :created, location: @number }
      else
        format.html { render :new }
        format.json { render json: @number.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /numbers/1
# PATCH/PUT /numbers/1.json
  def update
    session[:app_id]=params[:number][:app_id]
    respond_to do |format|
      if @number.update(number_params)
        format.html { redirect_to numbers_path(:app_id => @number.app_id), notice: 'Number was successfully updated.' }
        format.json { render :show, status: :ok, location: @number }
      else
        format.html { render :edit }
        format.json { render json: @number.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /numbers/1
# DELETE /numbers/1.json
  def destroy
    app_id = @number.app_id
    @number.destroy
    respond_to do |format|
      format.html { redirect_to numbers_path(:app_id => app_id) }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_number
    @number = Number.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def number_params
    params.require(:number).permit(:title, :value, :app_id, :edit_flag)
  end

end
