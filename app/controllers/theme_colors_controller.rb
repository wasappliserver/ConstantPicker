class ThemeColorsController < ApplicationController
  before_action :set_theme_color, only: [:show, :edit, :update, :destroy]

  # GET /theme_colors
  # GET /theme_colors.json
  def index
    @user=User.find(session[:user_id])
    @app = @user.apps.find(params[:app_id])
    ThemeColorsHelper.updateTheme @app.id
    @theme_colors = ThemeColor.where("app_id = '#{@app.id}'")
  end

  # GET /theme_colors/1
  # GET /theme_colors/1.json
  def show
  end

  # GET /theme_colors/new
  def new
    @theme_color = ThemeColor.new
  end

  # GET /theme_colors/1/edit
  def edit
  end

  # POST /theme_colors
  # POST /theme_colors.json
  def create
    @theme_color = ThemeColor.new(theme_color_params)
    @theme_color.app_id = params[:theme_color][:app_id]
    respond_to do |format|
      if @theme_color.save
        format.html { redirect_to theme_colors_path(:app_id => @theme_color.app_id), notice: 'Theme color was successfully created.' }
        format.json { render :show, status: :created, location: @theme_color }
      else
        format.html { render :new }
        format.json { render json: @theme_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /theme_colors/1
  # PATCH/PUT /theme_colors/1.json
  def update
    session[:app_id]=params[:theme_color][:app_id]
    respond_to do |format|
      if @theme_color.update(theme_color_params)
        @theme_color.color = @theme_color.color.gsub("#", "0x")
        @theme_color.save
        format.html { redirect_to theme_colors_path(:app_id => @theme_color.app_id), notice: 'Theme color was successfully updated.' }
        format.json { render :show, status: :ok, location: @theme_color }
      else
        format.html { render :edit }
        format.json { render json: @theme_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /theme_colors/1
  # DELETE /theme_colors/1.json
  def destroy
    app_id = @theme_color.app_id
    @theme_color.destroy
    respond_to do |format|
      format.html { redirect_to theme_colors_path(:app_id => app_id), notice: 'Theme color was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_theme_color
    @theme_color = ThemeColor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def theme_color_params
    params.require(:theme_color).permit(:app_id, :color, :name)
  end
end
