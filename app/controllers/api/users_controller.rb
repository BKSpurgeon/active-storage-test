class Api::UsersController < ApplicationController
  def create
    user = User.new(create_params)
    # byebug
    # ActionController::Parameters {"user"=><ActionController::Parameters {"username"=>"Test User"
    #, "avatar"=><ActionController::Parameters {"original_filename"=>"avatar.jpg", "tempfile"=>"#<File:0x0000565318c55898>", "content_type"=>"image/jpg"} permitted: false>} permitted: false>, "format"=>:json, "controller"=>"api/users", "action"=>"create"} permitted: false>
    # The params are not permitted. They should be.

    if user.save
      render json: success_json(user), status: :created
    else
      render json: error_json(user), status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:username, :avatar)
  end

  def success_json(user)
    {
      user: {
        id: user.id,
        username: user.username,
      }
    }
  end

  def error_json(user)
    { errors: user.errors.full_messages }
  end
end
