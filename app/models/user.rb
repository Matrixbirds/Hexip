class User < ActiveRecord::Base
  has_many :articles, foreign_key: :author_id
  validates :name, presence: true
  validates :access_token, presence: true
end
