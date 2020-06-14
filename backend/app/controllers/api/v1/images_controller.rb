module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: [:show, :update, :destroy]
    
      # GET /images
      def index
        @images = Image.all.order(id: "DESC")
      
        render json: images_json
      end
    
      # GET /images/1
      def show
        render json: image_json
      end
    
      # POST /images
      def create
        @image = Image.new(image_params)
      
        if @image.save
          render json: image_json, status: :created
        else
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /images/1
      def update
        if @image.update(image_params)
          render json: image_json
        else
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /images/1
      def destroy
        if @image.destroy
          render json: image_json
        else
          render json: @image.errors, status: :unprocessable_entity
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_image
          @image = Image.find(params[:id])
        end
      
        # Only allow a trusted parameter "white list" through.
        def image_params
          params.require(:image).permit(:description, :data)
        end

        def image_json
          json = @image.to_json
          if @image.data.attached?
            json = JSON.parse(json).merge({
              url: url_for(@image.data)
            })
          end
          json
        end

        def images_json
          jsons = []
          @images.each do |image|
            json = JSON.parse(image.to_json)
            if image.data.attached?
              json.merge!({
                url_thumb: url_for(image.data.variant(resize: "256x256")),
                url: url_for(image.data)
              })
            end
            jsons << json
          end
          jsons
        end
    end
  end
end
