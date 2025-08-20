class Quest < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :status, inclusion: { in: [ true, false ] }
end
