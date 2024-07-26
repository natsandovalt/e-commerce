class ApplicationForm
  include ActiveModel::API
  include ActiveModel::Attributes

  def save
    return false unless valid?

    with_transaction { submit! }
  end

  private

    def with_transaction(&)
      ApplicationRecord.transaction(&)
    end

    def submit!
      raise NotImplementedError
    end
end
