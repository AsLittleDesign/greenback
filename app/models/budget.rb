class Budget < ActiveRecord::Base
  has_paper_trail :class_name => 'BudgetVersion'

  validates :name, presence: true, length: { minimum: 2 }
  validates :amount, presence: true, length: { minimum: 2 }
end