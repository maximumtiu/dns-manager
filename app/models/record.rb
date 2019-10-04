class Record < ApplicationRecord
  TYPES_OF = %w(A AAAA ALIAS CNAME NS PTR SPF TXT).freeze

  belongs_to :zone
  validates_presence_of :type_of
  validates_presence_of :rdata
  validates_inclusion_of :type_of, in: TYPES_OF
  validates_uniqueness_of :type_of, scope: :zone_id
end
