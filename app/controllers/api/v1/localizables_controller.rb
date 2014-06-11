module Api
  module V1
    class LocalizablesController < ApplicationController
      skip_before_action :authorize
      skip_before_action :verify_authenticity_token
      respond_to :json

      def index
        app = App.where("name = '#{params[:name]}'")
        loc = Localizable.where("app_id = #{app[0].id}")
        respond_with loc
      end

      def show
        respond_with Localizable.find(params[:app_id])
      end

      def create
        #compute the token into app_id
        app = App.where(:app_token => params[:app_token])
        if (app.size!=0)
          params[:localizable].merge(:app_id => app[0].id)
          loc = Localizable.new(params[:localizable].permit(:key_loc, :value, :lang, :app_token, :missing))
          loc.app = app[0]
          loc.save
          respond_with loc
        end
      end

      def update
        respond_with Localizable.update(params[:app_id], params[:localizables])
      end

      def destroy
        respond_with Localizable.destroy(params[:app_id])
      end
    end
  end
end