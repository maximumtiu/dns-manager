module Ns1
  class Zone < Base
    # GET /zones
    def self.index
      read('/zones')
    end

    def self.show(zone_name)
      read("/zones/#{zone_name}")
    end

    # PUT /zones/:zone-name
    # Relevant response info: "dns_servers" are necessary for our users
    def self.create(zone_name)
      body = { "zone" => "#{zone_name}" }
      write("/zones/#{zone_name}", :put, body)
    end

    # POST /zones/:zone-name
    def self.update(zone_name)
      body = { "zone" => "#{zone_name}" }
      write("/zones/#{zone_name}", :post, body)
    end

    # DELETE /zones/:zone-name
    def self.delete(zone_name)
      delete("/zones/#{zone_name}")
    end
  end
end
