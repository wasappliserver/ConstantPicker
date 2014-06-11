require 'net/http'


class MenuController < ApplicationController
  skip_before_action :authorize

  def home
  end

  def trigger_build
    puts params.to_s

    app = params[:name]
    app= app.gsub(/([ ])/,"%20")
    uri = URI("http://server.mobservic.es:8080/jenkins/view/#{app}/job/#{app}/build")
    req = Net::HTTP::Post.new(uri)
    req.basic_auth 'bitbucket', 'wasapplibitbucket'

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        trigger = true
      # OK
      else
        trigger = false
        res.value
    end

    if (trigger == true)
      flash[:success] = "Build triggered"
    else
      flash[:error] = "Something went wrong when triggering"
    end
    redirect_to start_jenkins_path(:name => params[:name])

  end
end
