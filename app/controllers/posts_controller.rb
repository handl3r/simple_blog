class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Create post successfully' }
        format.json do
          render json: { post_status: 'created',
                                     post_id: "#{@post.id}",
                                     created_at: @post.created_at.to_time.strftime("%M:%I %p %m/%d/%Y") }
        end
      else
        format.html { render :new }
        format.json { render json: @post.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Update user successfully' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Destroy post successfully' }
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    full_params = params.require(:post).permit(:title, :body)
    full_params[:user_id] = current_user.id
    full_params
  end
end
