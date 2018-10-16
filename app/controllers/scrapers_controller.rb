class ScrapersController < ApplicationController
  def new
    @scraper = Scraper.new
  end

  def create
    @scraper = Scraper.new(scraper_params)
    if @scraper.save
      render json: @scraper.search_response
    else
      rnder :new
    end
  end

  private

  def scraper_params
    params.require(:scraper).permit(:keyword, :limit, :device)
  end
end