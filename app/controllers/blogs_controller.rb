class BlogsController < ApplicationController
  def index
    user_id = params[:user_id]
    # raise user_id
    unless User.exists? user_id
      redirect_to error_path, alert: "User does not exist with id: #{user_id}"
      return
    end
    @user = User.find user_id
  end

  def show
    user_id = params[:user_id]
    blog_id = params[:id]
    if Blog.exists? id: blog_id, user_id: user_id
      @blog = Blog.find blog_id
      @user = User.find user_id
    else
      redirect_to error_path, alert: "No blog exist wither user id: #{user_id} & blog id: #{blog_id}"
    end
  end

  def edit
    user_id = params[:user_id]
    blog_id = params[:id]
    if Blog.exists? id: blog_id, user_id: user_id
      @user = User.find user_id
      @blog = @user.blogs.find blog_id
    else
      redirect_to error_path, alert: "No blog exist wither user id: #{user_id} & blog id: #{blog_id}"
    end
  end

  def update

    user_id = params[:user_id]
    blog_id = params[:id]
    if Blog.exists? id: blog_id, user_id: user_id
      @user = User.find user_id
      @blog = @user.blogs.find blog_id
      @blog.update(blog_params)
      redirect_to user_blog_path(@user, @blog)
    else
      redirect_to error_path, alert: "No blog exist wither user id: #{user_id} & blog id: #{blog_id}"
    end

  end

  def destroy
    blog_id = params[:id]
    user_id = params[:user_id]
    if Blog.exists? id: blog_id, user_id: user_id
      Blog.find(blog_id).destroy
      redirect_to user_blogs_path, alert: "Blog is deleted"
    else
      redirect_to user_blogs_path, alert: "Blog is not found to delete"
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
