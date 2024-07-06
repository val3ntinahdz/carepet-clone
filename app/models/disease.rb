class Disease < ApplicationRecord
  has_many :conditions, dependent: :destroy
end
