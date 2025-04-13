class Url < ApplicationRecord
    validates :original, presence: true, uniqueness: true
    validates :short, presence: true, uniqueness: true
  end
  