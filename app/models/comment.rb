class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_to, polymorphic: true
end
