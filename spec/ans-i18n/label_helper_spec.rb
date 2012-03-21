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
        @default = "デフォルト"
        @helper.t_message @attr, @default
      end

      it "は、 messages からメッセージを取得する" do
        ::I18n.should have_received.t("messages.article.#{@attr}", default: @default)
      end
    end

    describe "#t_message(key,replaces)" do
      before do
        @attr = :attr

        stub(::I18n).t("messages.article.#{@attr}", default: "default"){@message}

        controller = Object.new
        stub(controller).controller_name { "articles" }
        stub(@helper).controller { controller }
      end

      it "は、 messages からメッセージを取得し、置換して返す" do
        @message = ":key:のメッセージ"
        @helper.t_message(@attr, "default", key: "value").should == "valueのメッセージ"
      end
      it "は、正規表現の特殊文字をキーにしたハッシュでも正しく置換して返す" do
        @message = ":[name]:のメッセージ"
        @helper.t_message(@attr, "default", "[name]" => "value").should == "valueのメッセージ"
      end
    end

    describe "#t_message_model" do
      before do
        stub(::I18n).t

        @model = :model
        @attr = :attr
        @default = "デフォルト"
        @helper.t_message_model @model, @attr, @default
      end

      it "は、 messages からラベルを取得する" do
        ::I18n.should have_received.t("messages.#{@model}.#{@attr}", default: @default)
      end
    end

    describe "#t_message_key をオーバーライドする" do
      before do
        stub(::I18n).t

        class << @helper
          def t_message_key
            "scoped.messages"
          end
        end

        @model = :model
        @attr = :attr
        @default = "デフォルト"
        @helper.t_message_model @model, @attr, @default
      end

      it "は、 scoped.messages からラベルを取得する" do
        ::I18n.should have_received.t("scoped.messages.#{@model}.#{@attr}", default: @default)
      end
    end

    describe "#l_default" do
      before do
        @action = proc{
          @helper.l_default @time
        }
      end

      context "引数が Time の場合" do
        before do
          stub(::I18n).l
          @time = Time.now
        end
        it "は、 default で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :default)
        end
      end

      context "引数が Date の場合" do
        before do
          stub(::I18n).l
          @time = Date.today
        end
        it "は、 default で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :default)
        end
      end

      context "引数が nil の場合" do
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

    end

    describe "#l_short" do
      before do
        @action = proc{
          @helper.l_short @time
        }
      end

      context "引数が Time の場合" do
        before do
          stub(::I18n).l
          @time = Time.now
        end
        it "は、 short で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :short)
        end
      end

      context "引数が Date の場合" do
        before do
          stub(::I18n).l
          @time = Date.today
        end
        it "は、 short で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :short)
        end
      end

      context "引数が nil の場合" do
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

    end

    describe "#l_long" do
      before do
        @action = proc{
          @helper.l_long @time
        }
      end

      context "引数が Time の場合" do
        before do
          stub(::I18n).l
          @time = Time.now
        end
        it "は、 long で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :long)
        end
      end

      context "引数が Date の場合" do
        before do
          stub(::I18n).l
          @time = Date.today
        end
        it "は、 long で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :long)
        end
      end

      context "引数が nil の場合" do
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

    end

    describe "#l_month_day" do
      before do
        @action = proc{
          @helper.l_month_day @time
        }
      end

      context "引数が Time の場合" do
        before do
          stub(::I18n).l
          @time = Time.now
        end
        it "は、 month_day で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :month_day)
        end
      end

      context "引数が Date の場合" do
        before do
          stub(::I18n).l
          @time = Date.today
        end
        it "は、 month_day で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :month_day)
        end
      end

      context "引数が nil の場合" do
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

    end

    describe "#l_only_time" do
      before do
        @action = proc{
          @helper.l_only_time @time
        }
      end

      context "引数が Time の場合" do
        before do
          stub(::I18n).l
          @time = Time.now
        end
        it "は、 only_time で l メソッドを呼び出す" do
          @action.call
          ::I18n.should have_received.l(@time, format: :only_time)
        end
      end

      context "引数が Date の場合" do
        before do
          stub(::I18n).l
          @time = Date.today
        end
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

      context "引数が nil の場合" do
        it "は、 nil を返す" do
          @action.call.should be_nil
        end
      end

    end

  end
end
