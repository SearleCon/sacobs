class CostInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.content_tag(:span, 'R', class: 'input-group-addon') +
        @builder.text_field(attribute_name, input_html_options)
    end
  end
end
