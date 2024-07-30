class BillingPlansRepository < ApplicationRepository
  def find(id)
    model.find_by(plan_id: id)
  end
  
  def existing_plans
    plans = all.each_with_object({}) do |plan, obj|
      obj[plan.plan_id] = plan
    end
    plans
  end

  def subscribe(attrs)
    model.create!(attrs)
  end

  def expired_plans(ids)
    model.where.not({ plan_id: ids })
  end

  def unsubscribe(obj)
    obj.destroy
  end
end