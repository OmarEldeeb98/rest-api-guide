class Fact < ApplicationRecord
  belongs_to :user
  validates :fact, presence: true, length:{minimum: 3}
end
