class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, presence: true
  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 } # максимальная длина 255 символов
end
