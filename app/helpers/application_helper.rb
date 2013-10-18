module ApplicationHelper

  def title(page_title)
    default_title = "Portfolio"
    page_title.empty? ? default_title : "#{default_title}" | "#{page_title}"
  end

end
