# frozen_string_literal: true

class Image < ApplicationRecord
  has_one_attached :data
end
