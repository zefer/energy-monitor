require 'json'

class ElectricityUsage
  attr_reader :trans, :mac, :time, :current, :today

  def self.from_raw(message)
    m = message.sub(/.*\{/, '{')
    d = JSON.parse(m)

    unless d['fn'] == 'meterData'
      puts "Ignoring message: #{message}"

      return nil
    end

    new(d['trans'], d['mac'], d['time'], d['cUse'], d['todUse'])
  rescue JSON::ParserError
    puts "Invalid message: #{message}"
  end

  def initialize(trans, mac, time, current, today)
    @trans = trans
    @mac = mac
    @time = time
    @current = current
    @today = today
  end

  def to_s
    "[#{Time.at(@time).utc}] #{self.class.name}: #{@current} W"
  end
end
