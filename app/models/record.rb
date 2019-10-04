class Record < ApplicationRecord
  belongs_to :zone
  validates_presence_of :type_of
  validates_presence_of :rdata
end
