require_relative "conf"

module IRB
  module HelperMethod
    class IrbContext < Conf
      category "IRB"
      description "Returns the current context."

      def execute
        IRB.CurrentContext
      end
    end
  end
end
