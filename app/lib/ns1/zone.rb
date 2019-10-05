module Ns1
  class Zone < Base
    # GET /zones
    def self.index
      read('/zones')
    end

    # GET /zones/:zone-name
    def self.show(zone_name)
      read("/zones/#{zone_name}")
    end

    # PUT /zones/:zone-name
    # Relevant response info: "dns_servers" are necessary for our users
    def self.create(zone_name)
      body = { "zone" => "#{zone_name}" }
      write("/zones/#{zone_name}", :put, body)
    end

    # DELETE /zones/:zone-name
    def self.destroy(zone_name)
      delete("/zones/#{zone_name}")
    end
  end
end
