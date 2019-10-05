module Ns1
  class Record < Base
    # PUT /zones/:zone-name/:domain/:record-type
    def self.create(zone_name, domain, type, ttl, answers = [])
      body = {
        'zone' => zone_name,
        'domain' => domain,
        'type' => type,
        'answers' => answers
      }
      write("/zones/#{zone_name}/#{domain}/#{type}", :put, body)
    end

    # POST /zones/:zone-name/:domain/:record-type
    def self.update(zone_name, domain, type, ttl, answers = [])
      body = {
        'zone' => zone_name,
        'domain' => domain,
        'type' => type,
        'answers' => answers
      }
      write("/zones/#{zone_name}/#{domain}/#{type}", :post, body)
    end

    # DELETE /zones/:zone-name/:domain/:record-type
    def self.destroy(zone_name, domain, type)
      delete("/zones/#{zone_name}/#{domain}/#{type}")
    end
  end
end
