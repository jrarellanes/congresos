class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :administrador?, :only => [:index, :create, :destroy, :new, :edit]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if params[:admin] == "1"
      @user.add_role 'admin'
    end
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
end
