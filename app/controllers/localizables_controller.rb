class LocalizablesController < ApplicationController
  before_action :set_localizable, only: [:show, :edit, :update, :destroy]

  # GET /localizables
  # GET /localizables.json
  def index
    @user=User.find(session[:user_id])
    if (params.has_key?("app_id"))
      @app = @user.apps.find(params[:app_id])
      LocalizablesHelper.getLang params[:app_id]
    end
  end

  # GET /localizables/1
  # GET /localizables/1.json
  def show
  end

  # GET /localizables/new
  def new
    @localizable = Localizable.new
  end

  # GET /localizables/1/edit
  def edit
  end

  # POST /localizables
  # POST /localizables.json
  def create
    @localizable = Localizable.new(localizable_params)
    # if (session[:user_id]==nil)
    #   if (params.has_key?(token))
    #     token = params[:token]
    #     app = App.where("token = #{token} ")
    #     @localizable.app = app
    #     puts @localizable.app_id
    #   end
    # else
      @localizable.app_id = params[:localizable][:app_id]
    # end

    respond_to do |format|
      if @localizable.save
        format.html { redirect_to localizables_path(:app_id => @localizable.app_id), notice: 'Localizable was successfully created.' }
        format.json { render :show, status: :created, location: @localizable }
      else
        format.html { render :new }
        format.json { render json: @localizable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /localizables/1
  # PATCH/PUT /localizables/1.json
  def update
    session[:app_id]=params[:localizable][:app_id]
    respond_to do |format|
      if @localizable.update(localizable_params)
        format.html { redirect_to localizables_path(:app_id => @localizable.app_id), notice: 'Localizable was successfully updated.' }
        format.json { render :show, status: :ok, location: @localizable }
      else
        format.html { render :edit }
        format.json { render json: @localizables.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /localizables/1
  # DELETE /localizables/1.json
  def destroy
    app_id = @localizable.app_id
    @localizable.destroy
    respond_to do |format|
      format.html { redirect_to localizables_path(:app_id => app_id) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_localizable
    @localizable = Localizable.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def localizable_params
    params.require(:localizable).permit(:key_loc, :value, :lang, :app_id, :missing)
  end

end
