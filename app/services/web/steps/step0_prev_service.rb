module Web
  module Steps
    class Step0PrevService
      include Interactor

      before do
        context.current_step = 0
      end

      def call
        context.record = nil
      end
    end
  end
end
