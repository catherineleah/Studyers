module ApplicationHelper
  def title
    base_title = "Studyers"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def current_class?(test_path)
    return 'active' if current_page?(test_path)
  end
  
  def user_notebooks
    return current_user.notebooks.order("updated_at DESC")
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def role?(user)
    return user.role
  end
end
