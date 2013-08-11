class TimePickerInput < SimpleForm::Inputs::FileInput
  def input
    out = '' # the output string we're going to build
    # check if there's an uploaded file (eg: edit mode or form not saved)
    (out << @builder.file_field(attribute_name, input_html_options)).html_safe
  end
end