class LinksController < ApplicationController
    before_action :set_link, only: [:show, :redirect]
  
    def index
      @link = Link.new
      @links = Link.all
    end
  
    def create
      @link = Link.new(link_params)
      @link.short_url = generate_short_url
      if @link.save
        redirect_to root_path, notice: 'Short URL created successfully'
      else
        render :index
      end
    end
  
    def show
      @link = Link.find_by!(short_url: params[:short_url])
      redirect_to @link.original_url
    end

    def destroy
      @link = Link.find(params[:id])
      @link.destroy
      redirect_to links_path, notice: 'Link was successfully deleted.'
    end
  
    def redirect
      if @link.original_url.start_with?('http://', 'https://')
        redirect_to @link.original_url, allow_other_host: true
      else
        # Handle URLs that do not start with http:// or https:// (e.g., relative paths)
        redirect_to root_path, alert: "Invalid URL"
      end
    end
  
    private
  
    def set_link
      @link = Link.find_by!(short_url: params[:short_url])
    end
  
    def link_params
      params.require(:link).permit(:original_url)
    end
  
    def generate_short_url
      SecureRandom.hex(3)
    end
end