class IpToCountry
  @@packed_ip_file = File.join(File.dirname(__FILE__), '..', 'bin', 'packed-ip.dat')
  @@white_list = [ '127.0.0.1' ]

  def self.white_list?( ip_address )
    @@white_list.include?( ip_address )    
  end
 
  def self.white_list; @@white_list; end
  
  def self.country_of( *arr )
    # the binary table file is looked up with each request
    File.open(@@packed_ip_file,"rb") do |rfile|
      rfile.seek(0,IO::SEEK_END)
      record_max=rfile.pos/10-1

      arr.each { |argv|
        # build a 4-char string representation of IP address
        # in network byte order so it can be a string compare below
        ipstr= argv.split(".").map {|x| x.to_i.chr}.join

        # low/high water marks initialized
        low,high=0,record_max
        while true
          mid=(low+high)/2       # binary search median
          rfile.seek(10*mid)     # one record is 10 byte, seek to position
          str=rfile.read(8)      # for range matching, we need only 8 bytes
          # at comparison, values are big endian, i.e. packed("N")
          if ipstr>=str[0,4]     # is this IP not below the current range?
            if ipstr<=str[4,4]   # is this IP not above the current range?
              result = rfile.read(2) # a perfect match, voila!
              return result == 'ZZ' ? nil : result
              break
            else
              low=mid+1          # binary search: raise lower limit
            end
          else
            high=mid-1           # binary search: reduce upper limit
          end
          if low>high            # no entries left? nothing found
            return nil 
            break
          end
        end
      }
    end
  end
end

