class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  #ともに必須
  validates :title, length: { maximum: 200 }

end
