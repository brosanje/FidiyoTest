  class AdminController < ApplicationController
  before_action :authenticate_user!

  
  def ng
    @base_url = '/admin'
    render :index
  end
