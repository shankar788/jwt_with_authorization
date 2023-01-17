class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json:User.all
  end

  def create
    @a = User.create(user_params)
    if @a.valid?
      render json:{message:"successful"}
    else
      render json:{error:@a.errors.full_messages}
    end
  end

  def update
  end

  def destory
  end

  def show
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token =  encode_token({user:@user.id})
      render json:{user:@user,token: token},status: :ok
    end 
  end  
  private
  def user_params
    params.permit(:email,:password)
  end  
end
