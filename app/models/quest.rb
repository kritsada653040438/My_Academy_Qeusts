class Quest < ApplicationRecord
  validates :name, presence: { message: "cannot be empty, please provide a quest name." }, length: { maximum: 100, too_long: "is too long, please keep it under %{count} characters." }
  validates :status, inclusion: { in: [ true, false ] }
end
