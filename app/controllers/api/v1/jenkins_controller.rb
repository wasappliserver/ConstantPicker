module Api
  module V1
    class JenkinsController < ActionController::Base
      skip_before_action :authorize
      skip_before_action :verify_authenticity_token
      respond_to :json

      def index
        @lines_final = ApplicationHelper.getStrings(params[:name])
        @constants = String.new

        @lines_final.each do |line|
          @constants += line.to_s
        end
        respond_to do |format|
          format.json { render :json => @constants }
        end
      end

    end
  end
end

