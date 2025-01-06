class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  # @rbs () -> void
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  # @rbs () -> void
  def show
    render json: @post
  end

  # POST /posts
  # @rbs () -> void
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # @rbs () -> void
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # @rbs () -> void
  def destroy
    @post.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # @rbs () -> void
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    # @rbs () -> Hash[Symbol, untyped]
    def post_params
      params.expect(post: [ :name, :title, :content ])
    end
end
