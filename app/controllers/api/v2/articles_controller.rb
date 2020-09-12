module Api
	module V2
		class ArticlesController < ApplicationController
			before_action :article_id, only: [:show, :update, :destroy]

			def index
				@articles = Article.order('created_at ASC')

				render json: {status: "Success", messages: "Loaded articles", data: @articles}, status: :ok
			end

			def show
				render json: {status: "Success", messages: "Loaded articles", data: @article}, status: :ok
			end

			def create
				@article = Article.new(articles_params)
				if @article.save
					render json: {status: "Success", messages: "Saved article", data: @article}, status: :ok
				else
					render json: {status: "Failed", messages: "Failed save article", data: @article.errors}, status: :unprocessable_entity
				end
			end

			def update
				if @article.update_attributes(articles_params)
					render json: {status: "Success", messages: "Updated article", data: @article}, status: :ok
				else
					render json: {status: "Failed", messages: "Failed Update article", data: @article.errors}, status: :unprocessable_entity
				end	
			end

			def destroy
				@article.destroy

				render json: {status: "Success", messages: "Deleted article", data: @article}, status: :ok
			end

			private
			def articles_params
				params.permit(:title, :body)
			end

			def article_id
				@article = Article.find(params[:id])
			end

		end
	end
end