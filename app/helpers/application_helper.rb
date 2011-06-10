module ApplicationHelper
  def title
    base_title = "Studyers"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
