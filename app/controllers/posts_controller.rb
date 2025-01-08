class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # @rbs () -> void
  def index
    @posts = Post.all

    render json: @posts
  end

  # @rbs () -> void
  def show
    render json: @post
  end

  # @rbs () -> void
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # @rbs () -> void
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # @rbs () -> void
  def destroy
    @post.destroy!
  end

  private

  # @rbs @posts: Post::ActiveRecord_Relation
  # @rbs @post: Post

  # @rbs () -> void
  def set_post
    @post = Post.find(params.expect(:id))
  end

  # @rbs () -> ActionController::Parameters
  def post_params
    params.expect(post: [ :name, :title, :content ])
  end
end
