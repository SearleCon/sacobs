module ApplicationHelper
  def title(title)
    content_for(:title, title)
  end

  def description(description)
    content_for(:description, description)
  end

  def keywords(keywords)
    content_for(:keywords, keywords)
  end

  def link_to(text, path, options = {}, &block)
    icon = options.delete(:icon)
    text = content_tag(:i, " #{text}", class: icon) if icon
    super
  end

  def errors_for(model)
    if model && model.errors.any?
      content_tag(:div, class: 'error_explanation well well small') do
        concat (content_tag(:div, "#{pluralize(model.errors.count, 'error')} prevented this record from being saved:", class: 'alert alert-error' ))
        concat ( content_tag(:ul) { model.errors.full_messages.map do |msg|
          content_tag(:li, msg)
        end.join().html_safe
        })
      end
    end
  end

  def iconize(name)
    "fa fa-#{name.to_s.gsub('_','-')}"
  end

end
