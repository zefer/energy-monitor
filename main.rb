require 'influxdb'
require 'mqtt'
require_relative 'lib/client'
require_relative 'lib/electricity_usage'

client = Client.new

influxdb = InfluxDB::Client.new(
  url: ENV['INFLUXDB_URL'] || 'http://user:pass@localhost:8086/dbname?retry=3'
)

mqtt = MQTT::Client.connect(ENV['MQTT_URL'])

loop do
  message = client.receive
  usage = ElectricityUsage.from_raw(message)
  next unless usage

  influxdb.write_point('lw_electricity',
    values: {
      current: usage.current,
      today: usage.today
    }
  )

  mqtt.publish('home/energy/lw_electricity/current', usage.current)
  mqtt.publish('home/energy/lw_electricity/today', usage.today.to_f / 1000)
end
