module SimpleServiceResult
  extend ActiveSupport::Concern

  included do
    attr_accessor :success, :message, :status

    def initialize(success, message, status)
      self.success, self.message, self.status = success, message, status
    end

    def success?
      success
    end
  end
end
