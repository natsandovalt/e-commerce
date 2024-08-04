class StripeClient < PaymentGateway
  def charge
    Stripe::Charge.create({
      amount: product.price_cents.to_s,
      currency: product.price.currency.to_s,
      description: product.name,
      source: order.token,
    })

  rescue Stripe::StripeError
    raise InvalidOperation
  end
end