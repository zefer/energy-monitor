require_relative 'lib/client'
require_relative 'lib/electricity_usage'

client = Client.new

loop do
  message = client.receive
  puts ElectricityUsage.from_raw(message).to_s
end
