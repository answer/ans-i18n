# vi: set fileencoding=utf-8

module Ans::I18n::LabelHelper
  def t_attr(attr)
    t_attr_model controller.controller_name.singularize, attr
  end
  def t_attr_model(model,attr)
    ::I18n.t "activerecord.attributes.#{model}.#{attr}"
  end

  def t_message(attr,default,replaces=nil)
    t_message_model controller.controller_name.singularize, attr, default, replaces
  end
  def t_message_model(model,attr, default,replaces=nil)
    ::I18n.t("#{t_message_key}.#{model}.#{attr}", default: default).tap{|result|
      replaces.try(:each) do |tag,value|
        result.gsub! /:#{Regexp.quote tag}:/, value
      end
    }
  end
  def t_message_key
    "messages"
  end
end
