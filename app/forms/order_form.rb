class OrderForm < ApplicationForm
  attribute :product_id
  attribute :payment_gateway

  def initialize(...)
    super
    @order = Order.new(product_id: product_id, payment_gateway: payment_gateway)
    PaymentGateway.gateway = gateway.new(order: @order)
  end

  private

    attr_reader :order  
    
    def submit!
      charge = PaymentGateway.charge
      set_paid(charge.id) if charge&.id.present?
      order.save!

    rescue InvalidOperation
      false
    end

    def gateway
      "#{payment_gateway.capitalize}Client".safe_constantize
    end

    def set_paid(charge_id)
      order.charge_id = charge.id
      order.set_paid
    end
end