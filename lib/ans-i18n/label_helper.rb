# vi: set fileencoding=utf-8

module Ans::I18n::LabelHelper
  def t_attr(attr)
    t_attr_model controller.controller_name.singularize, attr
  end
  def t_attr_model(model,attr)
    ::I18n.t "activerecord.attributes.#{model}.#{attr}"
  end
end
