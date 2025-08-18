class Todo < ApplicationRecord
  belongs_to :category

  enum :priority_level, {
    not_important_not_urgent: 0,
    important_not_urgent:     1,
    not_important_urgent:     2,
    important_urgent:         3
  }, default: :not_important_not_urgent
end
