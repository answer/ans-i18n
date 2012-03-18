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

    describe "#t_message" do
      before do
        stub(::I18n).t

        controller = Object.new
        stub(controller).controller_name { "articles" }
        stub(@helper).controller { controller }

        @attr = :attr
        @helper.t_message @attr
      end

      it "は、 messages からメッセージを取得する" do
        ::I18n.should have_received.t("messages.article.#{@attr}")
      end
    end

    describe "#t_message(key,replaces)" do
      before do
        @attr = :attr

        stub(::I18n).t("messages.article.#{@attr}"){@message}

        controller = Object.new
        stub(controller).controller_name { "articles" }
        stub(@helper).controller { controller }
      end

      it "は、 messages からメッセージを取得し、置換して返す" do
        @message = ":key:のメッセージ"
        @helper.t_message(@attr, key: "value").should == "valueのメッセージ"
      end
      it "は、正規表現の特殊文字をキーにしたハッシュでも正しく置換して返す" do
        @message = ":[name]:のメッセージ"
        @helper.t_message(@attr, "[name]" => "value").should == "valueのメッセージ"
      end
    end

    describe "#t_message_model" do
      before do
        stub(::I18n).t

        @model = :model
        @attr = :attr
        @helper.t_message_model @model, @attr
      end

      it "は、 messages からラベルを取得する" do
        ::I18n.should have_received.t("messages.#{@model}.#{@attr}")
      end
    end

  end
end
