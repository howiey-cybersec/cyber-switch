# Ping


## Understanding ICMP echo
ICMP - Internet Message Control Protocol
Lightweight protocol inside IP that carries diagnostic/control messages  - lets tools like ping and traceroute check network health without needing TCP/UDP
Ping is the first thing to check when a service seems off line -> if reachability fails, HTTP/SSH will too.

$ ping 8.8.8.8

Pinging 8.8.8.8 with 32 bytes of data:
Reply from 8.8.8.8: bytes=32 time=13ms TTL=114
Reply from 8.8.8.8: bytes=32 time=13ms TTL=114
Reply from 8.8.8.8: bytes=32 time=13ms TTL=114
Reply from 8.8.8.8: bytes=32 time=13ms TTL=114

Ping statistics for 8.8.8.8:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 13ms, Maximum = 13ms, Average = 13ms


# traceroute

## Under the hood
Crafts a probe with a tiny Time-To-Live (TTL) - a counter that routers decrement, when it hits 0 the router must drop the packet and send back an ICMP Time-Exceeded error
Windows [tracert] sends ICMP Echo request, Linux tracert sends a UDP packet packet to an unlikely port

The first router drops it, replies with ICMP (TTL gets decremented, ICMP Type 11, code 0 (time-exceeded)) with its own IP in the source field
Traceroute records address and RTT (time from send to reply)

Then, TTL is incremented and the process is repeated until it reaches Destination (or hop limit exceeded)
Each hop is recorded



$ tracert 8.8.8.8

Tracing route to dns.google [8.8.8.8]
over a maximum of 30 hops:

  1     1 ms     1 ms     2 ms  DeviceDHCP.Home [192.168.1.1]
  2     3 ms     3 ms     3 ms  xxx.xxx.xxx.x
  3     4 ms     3 ms     3 ms  x.xx.xxx.xx
  4     7 ms     7 ms     6 ms  38.142.223.180
  5    50 ms     9 ms     9 ms  port-channel8413.ccr91.dca04.atlas.cogentco.com [154.54.5.217]
  6    13 ms    12 ms    13 ms  be8073.ccr41.jfk02.atlas.cogentco.com [154.54.170.70]
  7    13 ms    12 ms    13 ms  be3294.ccr31.jfk05.atlas.cogentco.com [154.54.47.218]
  8     *        *        *     Request timed out.
  9     *        *       14 ms  63.243.218.9
 10     *       16 ms    14 ms  72.14.221.146
 11    14 ms    16 ms    14 ms  142.251.225.85
 12    15 ms    16 ms    15 ms  142.251.60.229
 13    13 ms    13 ms    13 ms  dns.google [8.8.8.8]
