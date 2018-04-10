class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
  validates :text, :user, presence: true
end
