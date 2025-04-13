class UrlsController < ApplicationController
    before_action :set_url, only: [:show, :destroy]
  
    def index
      render json: Url.all
    end
  
    def show
      render json: @url
    end
  
    def create
      original = params[:original]
  
      existing_url = Url.find_by(original: original)
      if existing_url
        return render json: existing_url, status: :ok 
      end
  
      unless original =~ URI::DEFAULT_PARSER.make_regexp
        return render json: { error: 'Invalid URL' }, status: :unprocessable_entity
      end
  
      short = SecureRandom.alphanumeric(6)
      url = Url.create(original: original, short: short)
      render json: url, status: :created
    end
  
    def destroy
      @url.destroy
      render json: { message: 'URL deleted successfully' }, status: :ok
    end
  
    def redirect
      url = Url.find_by(short: params[:short])
      if url
        redirect_to url.original, allow_other_host: true
      else
        render json: { error: 'Not Found' }, status: :not_found
      end
    end
  
    private
  
    def set_url
      @url = Url.find(params[:id])
    end
  end
  