class Receipt < ApplicationRecord
  has_one_attached :image
  belongs_to :shop
  belongs_to :editor, class_name: 'User', foreign_key: 'editor_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id' 

  enum category: {
    other: 0,
    food: 1,
    daily_necessities: 2,
    amusement: 3,
    clothing: 4,
    medical: 5,
    education: 6,
    travel: 7,
    communication: 8,
    lessons: 9,
  }
end
