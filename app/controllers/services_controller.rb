class ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def showVideoLibrary
    respond_to do |format|
      format.html {
        redirect_to clients_ng_path
      }
      format.json {
        render json: { videos: @videos }
      }
    end
  end
end
