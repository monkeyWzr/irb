# frozen_string_literal: true
require "irb"

require_relative "helper"

module TestIRB
  class HelperMethodTestCase < TestCase
    def setup
      $VERBOSE = nil
      @verbosity = $VERBOSE
      save_encodings
      IRB.instance_variable_get(:@CONF).clear
    end

    def teardown
      $VERBOSE = @verbosity
      restore_encodings
    end

    def execute_lines(*lines, conf: {}, main: self, irb_path: nil)
      IRB.init_config(nil)
      IRB.conf[:VERBOSE] = false
      IRB.conf[:PROMPT_MODE] = :SIMPLE
      IRB.conf.merge!(conf)
      input = TestInputMethod.new(lines)
      irb = IRB::Irb.new(IRB::WorkSpace.new(main), input)
      irb.context.return_format = "=> %s\n"
      irb.context.irb_path = irb_path if irb_path
      IRB.conf[:MAIN_CONTEXT] = irb.context
      IRB.conf[:USE_PAGER] = false
      capture_output do
        irb.eval_input
      end
    end
  end

  module TestHelperMethod
    class ConfTest < HelperMethodTestCase
      def test_conf_returns_the_context_object
        out, err = execute_lines("conf.ap_name")

        assert_empty err
        assert_include out, "=> \"irb\""
      end
    end

    class ContextTest < HelperMethodTestCase
      def test_context_returns_the_context_object_and_prints_deprecation_warning
        out, err = execute_lines("context.ap_name")

        assert_empty err
        assert_include out, "=> \"irb\""
      end
    end

    class IrbContextTest < HelperMethodTestCase
      def test_context_returns_the_context_object_and_prints_deprecation_warning
        out, err = execute_lines("irb_context.ap_name")

        assert_empty err
        assert_include out, "=> \"irb\""
      end
    end
  end
end
