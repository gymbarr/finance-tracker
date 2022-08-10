module ApplicationHelper
  def nav_tab(title, url, options = {})
    css_class = request.path == url ? 'active' : ''

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end
    
    link_to title, url, options
  end
end
