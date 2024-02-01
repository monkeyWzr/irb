module IRB
  module HelperMethod
    class Conf < Base
      category "IRB"
      description "Returns the current context."

      def execute
        IRB.CurrentContext
      end
    end
  end
end
