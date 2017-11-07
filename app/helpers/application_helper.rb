module ApplicationHelper
  def current_page path
    'class=active' if request.fullpath == path
  end
end
