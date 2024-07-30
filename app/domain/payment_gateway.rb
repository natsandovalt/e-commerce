class PaymentGateway
  class << self
    attr_writer :gateway
    delegate :active_plans, to: :gateway
    
    def gateway
      @backend = StripeClient.new
    end
  end

  class StripeClient
    def initialize
      @client = Stripe::Plan
    end
  
    def active_plans
      existing_plans = []
      
      @client.list({ active: true })["data"].each do |plan|
        existing_plans << {
          stripeid: plan["id"],
          stripe_plan_name: plan["nickname"],
          amount: plan["amount"],
        }
      end
  
      existing_plans
    end
  end

  class NoClient
    def active_plans
      []
    end
  end
end