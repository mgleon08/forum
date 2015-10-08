module Admin::UsersHelper

  def avatar(user)
    Gravatar.new(user.email).image_url
  end

  def my_friends_class?(friend)
    if current_user.friendships.include?(friend)
      "btn-primary disabled"
    else
      "btn-primary"
    end
  end


end
