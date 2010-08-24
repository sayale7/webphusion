class UsersController < ApplicationController

  def quit_account
    user = User.find(20)
    user.destroy
    redirect_to '/'
  end
  
end