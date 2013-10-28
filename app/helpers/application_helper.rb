module ApplicationHelper

  def title(page_title)
    default_title = "Portfolio"
    page_title.empty? ? default_title : "#{default_title}" | "#{page_title}"
  end

  # additional Devise helper
  def current_user?(user)
    current_user == user
  end

end
