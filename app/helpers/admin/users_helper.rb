module Admin::UsersHelper

  def avatar(user)
    Gravatar.new(user.email).image_url
  end

end
