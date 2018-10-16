class ScrapersController < ApplicationController
  def new
    @scraper = Scraper.new
  end

  def create
    @scraper = Scraper.new(scraper_params)
    if @scraper.save
      @results = @scraper.reformat_response
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
        format.json { render json: @results }
      end
    else
      render :new
    end
  end

  private

  def scraper_params
    params.require(:scraper).permit(:keyword, :limit, :device)
  end
end