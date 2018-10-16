class Shop < ApplicationRecord
  validates_uniqueness_of :uid
end
