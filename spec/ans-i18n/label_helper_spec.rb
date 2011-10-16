# vi: set fileencoding=utf-8

require 'spec_helper'

module Ans::I18n
  describe LabelHelper do
    before do
      @helper = Object.new
      class << @helper
        include LabelHelper

        def controller
        end
      end
    end

    describe "#t_attr" do
      before do
        stub(::I18n).t

        controller = Object.new
        stub(controller).controller_name { "articles" }
        stub(@helper).controller { controller }

        @attr = :attr
        @helper.t_attr @attr
      end

      it "は、 activerecord.attributes からラベルを取得する" do
        ::I18n.should have_received.t("activerecord.attributes.article.#{@attr}")
      end
    end

    describe "#t_attr_model" do
      before do
        stub(::I18n).t

        @model = :model
        @attr = :attr
        @helper.t_attr_model @model, @attr
      end

      it "は、 activerecord.attributes からラベルを取得する" do
        ::I18n.should have_received.t("activerecord.attributes.#{@model}.#{@attr}")
      end
    end

  end
end
