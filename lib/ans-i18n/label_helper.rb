# vi: set fileencoding=utf-8

module Ans::I18n::LabelHelper
  def t_attr(attr)
    t_attr_model controller.controller_name.singularize, attr
  end
  def t_attr_model(model,attr)
    ::I18n.t "activerecord.attributes.#{model}.#{attr}"
  end

  def t_message(attr,replaces=nil)
    t_message_model controller.controller_name.singularize, attr, replaces
  end
  def t_message_model(model,attr,replaces=nil)
    ::I18n.t("messages.#{model}.#{attr}").tap{|result|
      replaces.try(:each) do |tag,value|
        result.gsub! /:#{Regexp.quote tag}:/, value
      end
    }
  end
end
