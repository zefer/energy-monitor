require 'influxdb'
require_relative 'lib/client'
require_relative 'lib/electricity_usage'

client = Client.new

influxdb = InfluxDB::Client.new(
  url: ENV['INFLUXDB_URL'] || 'http://user:pass@localhost:8086/dbname?retry=3'
)

loop do
  message = client.receive
  usage = ElectricityUsage.from_raw(message)
  next unless usage

  data = {
    values: {
      current: usage.current,
      today: usage.today
    }
  }

  influxdb.write_point('lw_electricity', data)
end
