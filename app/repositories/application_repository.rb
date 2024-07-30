class ApplicationRepository
  class << self
    attr_writer :model_name

    def model_name
      @model_name ||= name.sub(/Repository$/, "").singularize
    end

    def model
      model_name.safe_constantize
    end
  end

  delegate :model, to: :class

  def all
    model.all.to_a
  end

  def find(id)
    model.find_by(id: id)
  end

  def add(attrs)
    model.create!(attrs)
  end

  def update(obj, attrs)
    obj.update!(attrs)
  end
end