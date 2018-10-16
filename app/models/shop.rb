# frozen_string_literal: true

class Shop < ApplicationRecord
  validates :uid, uniqueness: true
end
