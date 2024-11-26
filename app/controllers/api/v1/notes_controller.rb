module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: %i[show update destroy]

      # GET /notes
      def index
      # 現在ログイン中のユーザーの関連する notes を取得
      notes = Note.includes(:bean, :recipe)
                  .where(beans: { user_id: current_api_v1_user.id }, recipes: { user_id: current_api_v1_user.id })
                  .references(:bean, :recipe)
        render json: notes.as_json(
          include: {
            bean: { only: [:name] },
            recipe: { only: [:title] }
          }
        )
      end

      # GET /notes/:id
      def show
        render json: @note.as_json(
          include: {
            bean: { only: [:id, :name] },
            recipe: { only: [:id, :title] }
          }
        )
      end

      # POST /notes
      def create
        note = Note.new(note_params)
        if note.save
          render json: note, status: :created
        else
          render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /notes/:id
      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      # DELETE /notes/:id
      def destroy
        @note.destroy
        head :no_content
      end
    
      private
    
      def set_note
        @note = Note.find(params[:id])
      end
    
      def note_params
        params.require(:note).permit(:bean_id, :recipe_id, :taste_x, :taste_y, :comment)
      end
    end
  end
end