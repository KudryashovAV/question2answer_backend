class User < ApplicationRecord
  has_many :answers
  has_many :comments
  has_many :questions
end
