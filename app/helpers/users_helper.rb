module UsersHelper
  def gravatar_for(user, options = {})
    options = { :size => 120 }.merge(options)
    options[:default] = image_path("http://studyers.com/assets/default_icon.jpg")
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
