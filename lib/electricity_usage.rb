class ElectricityUsage
  attr_reader :trans, :mac, :time, :current, :today

  def self.from_raw(message)
    m = message.sub('*!', '')
    d = JSON.parse(m)

    return unless d['fn'] == 'meterData'

    new(d['trans'], d['mac'], d['time'], d['cUse'], d['todUse'])
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
