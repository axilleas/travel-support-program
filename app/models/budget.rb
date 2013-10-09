#
# A certain amount of money (in a given currency) to spend in a group of events
#
# A budget object can represent a periodic budget (like 'money to spend in Q2 of
# year 2013'), specific budgets for a givent event or any other amount of money.
# Budgets are defined for a specific currency and needs to be explicity
# associated to a group of events. If an event is associated to several budgets
# with the same currency, the amounts are added.
#
class Budget < ActiveRecord::Base
  attr_accessible :name, :description, :amount, :currency, :event_ids
  # Events that are covered by the budget
  has_and_belongs_to_many :events

  validates :name, :amount, :currency, :presence => true

  audit(:create, :update, :destroy) {|m,u,a| "#{a} performed on Budget by #{u.try(:nickname)}"}
end