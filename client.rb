require 'socket'
require 'ipaddr'
require 'json'
require_relative 'electricity_usage'

class Client
  MULTICAST_ADDR = '224.0.0.1'.freeze
  BIND_ADDR = '0.0.0.0'.freeze
  PORT = 9761

  def initialize
    @socket = UDPSocket.new
    membership = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(BIND_ADDR).hton

    @socket.setsockopt(:IPPROTO_IP, :IP_ADD_MEMBERSHIP, membership)
    @socket.setsockopt(:IPPROTO_IP, :IP_MULTICAST_TTL, 1)
    @socket.setsockopt(:SOL_SOCKET, :SO_REUSEPORT, 1)

    @socket.bind(BIND_ADDR, PORT)
  end

  def listen
    loop do
      m, = @socket.recvfrom(2000)
      puts ElectricityUsage.from_raw(m).to_s
    end
  end
end

Client.new.listen
