class ServicesController < ApplicationController
  before_action :require_login

  def index
    @posts = apply_simulated_changes(JsonPlaceholderService.new.posts)
  rescue Faraday::Error
    @posts = []
    flash.now[:alert] = "No fue posible consultar JSONPlaceholder."
  end

  def create
    result = JsonPlaceholderService.new.create_post(title: params[:title], body: params[:body])

    if result[:status] == 201
      session[:created_posts] ||= []
      session[:created_posts].unshift(result[:body])
      redirect_to services_path, notice: "Publicacion simulada creada con codigo 201."
    else
      redirect_to services_path, alert: "JSONPlaceholder no respondio 201."
    end
  end

  def update
    JsonPlaceholderService.new.update_post(params[:id], title: params[:title], body: params[:body])
    session[:edited_posts] ||= {}
    session[:edited_posts][params[:id].to_s] = { "title" => params[:title], "body" => params[:body] }
    redirect_to services_path, notice: "Publicacion simulada actualizada."
  end

  def destroy
    JsonPlaceholderService.new.delete_post(params[:id])
    session[:deleted_post_ids] ||= []
    session[:deleted_post_ids] << params[:id].to_s
    session[:created_posts] = Array(session[:created_posts]).reject { |post| post["id"].to_s == params[:id].to_s }
    redirect_to services_path, notice: "Publicacion simulada eliminada."
  end

  private

  def apply_simulated_changes(posts)
    deleted_ids = Array(session[:deleted_post_ids])
    edited_posts = session[:edited_posts] || {}
    created_posts = Array(session[:created_posts])

    visible_posts = posts.reject { |post| deleted_ids.include?(post["id"].to_s) }
    visible_posts = visible_posts.map do |post|
      edited_posts[post["id"].to_s] ? post.merge(edited_posts[post["id"].to_s]) : post
    end

    created_posts + visible_posts
  end
end
