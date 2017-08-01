require "fileutils"
require "ostruct"

class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  @@allowed_extensions = Hash["jpg jpeg gif png mp3 mp4 wma webm webp".split.collect { |vv| [vv, 1] }]
  @@allowed_mime_types = Hash["video/mp4 video/webm audio/mp3 audio/wma image/jpeg image/png image/gif image/webp".split.collect { |vv| [vv,1] }]

  # GET /videos
  # GET /videos.json
  def index
    if params[:keywords].present?
      @videos = Video.where("user_id = ? and description like ?", current_user.id, "%#{params[:keywords]}%").order("created_at desc")
    else
      @videos = Video.where(user: current_user)
    end


    respond_to do |format|
      format.html {
      }

      format.json {
        render json: { videos: @videos }
      }
    end

  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])


    respond_to do |format|
      format.html {
      }

      format.json {
        render json: { video: @video }
      }
    end

  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    uploaded_hash = params[:video] ## ActionDispatch::Http::UploadedFile - stupid video[video]
    uploaded_actiondispatch = uploaded_hash ## ["video"]

    description = params[:description]
    name = uploaded_actiondispatch.original_filename
    mime_type = uploaded_actiondispatch.content_type
    uploaded_io = uploaded_actiondispatch.tempfile

    @user = current_user

    @saveVideo = OpenStruct.new
    @saveVideo.error = nil

    if uploaded_io && name
      if @@allowed_mime_types[mime_type]
        bs = VideoCloud.find_by(:backing_store => "local")
        vc = VideoCategory.find_by(:category => "any")

        @saveVideo.original_name = name
        @saveVideo.basename = File.basename(name)
        @saveVideo.extension = File.extname(name)
        @saveVideo.mime_type = mime_type
        @saveVideo.file_size = uploaded_io.length
        @saveVideo.saved_basename = sprintf("client%03d-user%06d-%s-%s-%s", 1, @user.id, @user.email, Time.now.strftime("%Y%m%d%H%M%S"), @saveVideo.basename).gsub(/\s/, "")
        @saveVideo.saved_filename = Rails.root.join(bs.access, @saveVideo.saved_basename)

        case uploaded_io
        when StringIO
          @saveVideo.tempfile = "in-memory"
          File.open(@saveVideo.saved_filename, "wb") { |file| file.write(uploaded_io.read) }
        when Tempfile
          @saveVideo.tempfile = uploaded_io.path

          ## client001-user999999-useremail-yyyymmddhhmmss-filename
          FileUtils.move(uploaded_io.path, @saveVideo.saved_filename);

          @video = Video.create({:isSelect => false, :color => "none", :user => @user, :description => description, :resource_path => @saveVideo.saved_basename, :video_cloud => bs, :video_category => vc })
        else
          @saveVideo.error = "unknown class for uploaded_io: #{uploaded_io.class.to_s}"
        end
      else
        @saveVideo.error = "Invalid mime type #{mime_type}"
      end
    else
      @saveVideo.error = "Missing uploaded file"
    end

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.fetch(:video, {})
    end
end
