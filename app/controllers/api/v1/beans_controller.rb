module Api
  module V1
    class BeansController < ApplicationController
      before_action :authenticate_api_v1_user! # devise-token-authで認証
      before_action :set_bean, only: %i[show update destroy]

      # GET /api/v1/beans
      def index
        #Rails.logger.debug "Received Params: #{params.inspect}"
        #Rails.logger.debug "Current User: #{current_api_v1_user.inspect}"

        per_page = (params[:per_page] || 10).to_i
        cursor = params[:cursor].to_i

        beans = current_api_v1_user.beans
        beans = beans.where('id > ?', cursor) if cursor.present? # カーソルがあればカーソルより後のデータを取得
        beans = beans.order(id: :asc).limit(per_page) # id順に並べて，指定数取得

        next_cursor = beans.last&.id # 次のカーソル
        
        render json: {
          beans: beans,
          next_cursor: next_cursor
        }
      end

      # GET /api/v1/beans/:id
      def show
        render json: @bean
      end

      # POST /api/v1/beans
      def create
        bean = current_api_v1_user.beans.build(bean_params)
        if bean.save
          render json: bean, status: :created
        else
          render json: { errors: bean.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/beans/:id
      def update
        if @bean.update(bean_params)
          render json: @bean
        else
          render json: { errors: @bean.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/beans/:id
      def destroy
        @bean.destroy
        head :no_content
      end

      # GET /api/v1/beans/all
      def all
        beans = current_api_v1_user.beans.order(id: :asc)
        render json: beans
      end

      private

      def set_bean
        @bean = current_api_v1_user.beans.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Bean not found' }, status: :not_found
      end

      def bean_params
        params.require(:bean).permit(:name, :roast, :process)
      end
    end
  end
end
