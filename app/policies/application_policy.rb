class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true
  delegate :permission?, to: :user

  alias_rule :index?, :show?, to: :view?
  alias_rule :new?, :create?, :edit?, :update?, to: :manage?

  class << self
    def inherited(subclass)
      resource_reader = subclass.name.demodulize.sub(/Policy$/, "").underscore
      alias_method :"#{resource_reader}", :record
    end
  end
end