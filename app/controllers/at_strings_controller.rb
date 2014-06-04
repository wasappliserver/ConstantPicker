class AtStringsController < ApplicationController
  before_action :set_at_string, only: [:show, :edit, :update, :destroy]

  # GET /at_strings
  # GET /at_strings.json
  def index
    @user=User.find(session[:user_id])
    @app = @user.apps.find(params[:app_id])
    ApplicationHelper.readHeader params[:app_id]
  end

  # GET /at_strings/1
  # GET /at_strings/1.json
  def show
  end

  # GET /at_strings/new
  def new
    @at_string = AtString.new
  end

  # GET /at_strings/1/edit
  def edit
  end

  # POST /at_strings
  # POST /at_strings.json
  def create
    @at_string = AtString.new(at_string_params)
    @at_string.app_id = params[:at_string][:app_id]

    value_tmp = @at_string.value.scan(/[^@"].+[^"]/)
    @at_string.value = value_tmp[0]

    respond_to do |format|
      if @at_string.save
        format.html { redirect_to at_strings_path(:app_id => @at_string.app_id), notice: 'At string was successfully created.' }
        format.json { render :show, status: :created, location: @at_string }
      else
        format.html { render :new }
        format.json { render json: @at_string.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /at_strings/1
  # PATCH/PUT /at_strings/1.json
  def update
    session[:app_id]=params[:at_string][:app_id]
    respond_to do |format|
      if @at_string.update(at_string_params)

        value_tmp = @at_string.value.scan(/[^@"].+[^"]/)
        @at_string.value = value_tmp[0]
        @at_string.save

        format.html { redirect_to at_strings_path(:app_id => @at_string.app_id), notice: 'At string was successfully updated.' }
        format.json { render :show, status: :ok, location: @at_string }
      else
        format.html { render :edit }
        format.json { render json: @at_string.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /at_strings/1
  # DELETE /at_strings/1.json
  def destroy
    app_id = @at_string.app_id
    @at_string.destroy
    respond_to do |format|
      format.html { redirect_to at_strings_path(:app_id => app_id)}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_at_string
    @at_string = AtString.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def at_string_params
    params.require(:at_string).permit(:title, :value, :app_id)
  end
end
