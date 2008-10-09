#!/usr/bin/ruby

# take command line or stdin -- the latter has performance advantage
# for long lists
if ARGV[0]
  arr=ARGV
else
  arr=$stdin
end

# the binary table file is looked up with each request
File.open("packed-ip.dat","rb") do |rfile|
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
          puts rfile.read(2) # a perfect match, voila!
          break
        else
          low=mid+1          # binary search: raise lower limit
        end
      else
        high=mid-1           # binary search: reduce upper limit
      end
      if low>high            # no entries left? nothing found
        puts "no country"
        break
      end
    end
  }
end
