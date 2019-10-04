class Record < ApplicationRecord
  belongs_to :zone
  validates_presence_of :type
  validates_presence_of :rdata
end
