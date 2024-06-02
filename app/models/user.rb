class User < ApplicationRecord
  has_many :answers, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :questions, dependent: :nullify

  validates :email, uniqueness: true
end
