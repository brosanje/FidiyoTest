require "fileutils"
require "ostruct"

class ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def showVideo
  end

  @@allowed_extensions = Hash["jpg jpeg gif png mp3 mp4 wma webm webp".split.collect { |vv| [vv, 1] }]
  @@allowed_mime_types = Hash["video/mp4 video/webm audio/mp3 audio/wma image/jpeg image/png image/gif image/webp".split.collect { |vv| [vv,1] }]

  def saveVideo
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
          ##uploaded_io.unlink

=begin
          if uploaded_io.size < 10*1024*1024
            File.open(Rails.root.join('public', 'uploads', name), "wb") { |file| file.write(uploaded_io.read) }
          else
            File.open(Rails.root.join('public', 'uploads', name), "wb") do |out|
              uploaded_io.open do |in|
                buffer="bytes"
                while in.read(1024*1024, buffer)
                  file.write(buffer)
                end
              end
            end
          end
=end

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
      format.text {
        render :text => if @saveVideo.error
            @saveVideo.error
          else <<-MESSAGE
            Uploaded:   #{@saveVideo.original_name}
            Mime Type:  #{@saveVideo.mime_type}
            Extension:  #{@saveVideo.extension}
            Size:       #{@saveVideo.file_size}
            Temp Path:  #{@saveVideo.tempfile}
            Saved Path: #{@saveVideo.saved_filename}
MESSAGE
          end
      }

      format.html {
      }

      format.json {
        render json: { video: @video }
      }
    end
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
