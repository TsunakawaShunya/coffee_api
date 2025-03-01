module Api
  module V1
    class RecipesController < ApplicationController
      before_action :authenticate_api_v1_user! # devise-token-authの認証
      before_action :set_recipe, only: [:show, :update, :destroy]

      # GET /recipes
      def index
        per_page = (params[:per_page] || 10).to_i
        cursor = params[:cursor].to_i

        recipes = current_api_v1_user.recipes
        recipes = recipes.where('id > ?', cursor) if cursor.present?
        recipes = recipes.order(id: :asc).limit(per_page)

        next_cursor = recipes.last&.id
        
        render json: {
          recipes: recipes,
          next_cursor: next_cursor
        }
      end

      # POST /recipes
      def create
        recipe = current_api_v1_user.recipes.build(recipe_params)
        if recipe.save
          render json: recipe, status: :created
        else
          render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /recipes/:id
      def show
        render json: @recipe
      end

      # PUT /recipes/:id
      def update
        if @recipe.update(recipe_params)
          render json: @recipe
        else
          render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /recipes/:id
      def destroy
        @recipe.destroy
        head :no_content
      end

      # GET /recipes/all
      def all
        recipes = current_api_v1_user.recipes.order(id: :asc)
        render json: recipes
      end

      private

      def set_recipe
        @recipe = current_api_v1_user.recipes.find_by(id: params[:id])
        render json: { error: "Recipe not found" }, status: :not_found if @recipe.nil?
      end

      def recipe_params
        params.require(:recipe).permit(:title, :method, :temp, :ratio, :comment)
      end
    end
  end
end
