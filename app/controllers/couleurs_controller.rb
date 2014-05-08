class CouleursController < ApplicationController
  before_action :set_couleur, only: [:show, :edit, :update, :destroy]

  # GET /couleurs
  # GET /couleurs.json
  def index
    @user=User.find(session[:user_id])
    if (params.has_key?(:format))
      @app = @user.apps.find(params[:format])
      ApplicationHelper.readHeader params[:format]
    elsif (session.has_key?(:app_id))
      @app = @user.apps.find(session[:app_id])
      ApplicationHelper.readHeader session[:app_id]
    end
  end

# GET /couleurs/1
# GET /couleurs/1.json
  def show
  end

# GET /couleurs/new
  def new
    @couleur = Couleur.new
  end

# GET /couleurs/1/edit
  def edit
  end

# POST /couleurs
# POST /couleurs.json
  def create
    @couleur = Couleur.new(couleur_params)

    respond_to do |format|
      if @couleur.save
        format.html { redirect_to @couleur, notice: 'Couleur was successfully created.' }
        format.json { render :show, status: :created, location: @couleur }
      else
        format.html { render :new }
        format.json { render json: @couleur.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /couleurs/1
# PATCH/PUT /couleurs/1.json
  def update
    session[:app_id]=params[:couleur][:app_id]
    respond_to do |format|
      if @couleur.update(couleur_params)
        format.html { redirect_to @couleur, notice: 'Couleur was successfully updated.' }
        format.json { render :show, status: :ok, location: @couleur }
      else
        format.html { render :edit }
        format.json { render json: @couleur.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /couleurs/1
# DELETE /couleurs/1.json
  def destroy
    @couleur.destroy
    respond_to do |format|
      format.html { redirect_to couleurs_url }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_couleur
    @couleur = Couleur.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def couleur_params
    params.require(:couleur).permit(:title, :coul_type, :value_coul, :app_id)
  end

end






