module LinkHelper

  def link_to(text, path, options = {}, &block)
    icon = iconize options.delete(:icon) unless options.empty?
    text = content_tag(:i, " #{text}", class: icon) if icon
    super
  end

  def iconize(name)
    "fa fa-#{name.to_s.gsub('_','-')}"
  end

  def back_to(path)
   link_to 'Back', path, class: t('buttons.primary'), icon: :arrow_left
  end
end