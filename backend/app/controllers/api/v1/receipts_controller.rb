module Api
  module V1
    class ReceiptsController < ApplicationController
      before_action :set_receipt, only: [:show, :update, :destroy]

      # GET /receipts
      def index
        @receipts = Receipt.all.order(id: "DESC")
      
        render json: receipts_json
      end
    
      # GET /receipts/1
      def show
        render json: receipt_json
      end
    
      # POST /receipts
      def create
        @receipt = Receipt.new(receipt_params)
      
        if @receipt.save
          render json: receipt_json, status: :created
        else
          render json: @receipt.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /receipts/1
      def update
        if @receipt.update(receipt_params)
          render json: receipt_json
        else
          render json: @receipt.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /receipts/1
      def destroy
        if @receipt.destroy
          render json: receipt_json
        else
          render json: @receipt.errors, status: :unprocessable_entity
        end
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_receipt
          @receipt = Receipt.find(params[:id])
        end
      
        # Only allow a trusted parameter "white list" through.
        def receipt_params
          params.require(:receipt).permit(:name, :image, :category, :shop_id, :editor_id, :owner_id, :purchased_at)
        end
      
        def receipt_json
          json = @receipt.to_json
          if @receipt.image.attached?
            json = JSON.parse(json).merge({
              url_thumb: url_for(@receipt.image.variant(resize: "256x256")),
              url: url_for(@receipt.image)
            })
          end
          json
        end
      
        def receipts_json
          jsons = []
          @receipts.each do |receipt|
            json = JSON.parse(receipt.to_json)
            if receipt.image.attached?
              json.merge!({
                url_thumb: url_for(receipt.image.variant(resize: "256x256")),
                url: url_for(receipt.image)
              })
            end
            jsons << json
          end
          jsons
        end
    end
  end
end
