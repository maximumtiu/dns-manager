class Record < ApplicationRecord
  TYPES_OF = %w(A AAAA ALIAS CNAME NS PTR SPF TXT).freeze

  belongs_to :zone
  validates_presence_of :type_of
  validates_presence_of :rdata
  validates_inclusion_of :type_of, in: TYPES_OF
  validates_uniqueness_of :type_of, scope: :zone_id
  validates_numericality_of :ttl, { greater_than_or_equal_to: 0 }
  # max integer size
  validates_numericality_of :ttl, { less_than_or_equal_to: 2147483647 }
end
