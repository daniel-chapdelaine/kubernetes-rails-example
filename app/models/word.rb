class Word < ApplicationRecord
  validates :text, presence: true, uniqueness: { case_sensitive: false }
end
