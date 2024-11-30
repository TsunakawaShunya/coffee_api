module Api
  module V1
    class RecipesController < ApplicationController
      before_action :authenticate_api_v1_user! # devise-token-authの認証
      before_action :set_recipe, only: [:show, :update, :destroy]

      # GET /recipes
      def index
        recipes = current_api_v1_user.recipes
        render json: recipes
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
