class PaymentGateway
  InvalidOperation = StandardError.new

  attr_reader :order
  attr_reader :product
  
  class << self
    attr_writer :gateway
    delegate :charge, to: :gateway
  end

  def initialize(order:)
    @order = order
    @product = order.product
  end
end