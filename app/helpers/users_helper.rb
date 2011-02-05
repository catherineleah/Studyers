module UsersHelper
  def gravatar_for(user, options = { :size => 50, :default => 'http://github.com/images/gravatars/gravatar-80.png' })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
