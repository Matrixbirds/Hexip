class Article < ActiveRecord::Base
  belongs_to :user, foreign_key: :author_id
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
end
