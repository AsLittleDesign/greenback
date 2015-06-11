class Bill < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :amount, presence: true, length: { minimum: 2 }
end
