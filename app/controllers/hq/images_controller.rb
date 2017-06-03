class Hq::ImagesController < Hq::ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @image = @place.images.new(params.require(:image).permit(:photo))
    if @image.save
      redirect_to hq_place_path(@place), notice: "Resim başarılı bir şekilde eklendi."
    else
      redirect_to hq_place_path(@place), notice: "Resim eklenemedi."
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @image = Image.find(params[:id])
    @image.destroy
    if @image.destroy!
      redirect_to hq_place_path(@place), notice: "Resim silndi."
    end
  end
end
