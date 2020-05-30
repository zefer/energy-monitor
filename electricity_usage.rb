class ElectricityUsage
  attr_reader :trans, :mac, :time, :current_usage, :today_usage

  def self.from_raw(message)
    m = message.sub('*!', '')
    d = JSON.parse(m)

    new(d['trans'], d['mac'], d['time'], d['cUse'], d['todUse'])
  end

  def initialize(trans, mac, time, current_usage, today_usage)
    @trans = trans
    @mac = mac
    @time = time
    @current_usage = current_usage
    @today_usage = today_usage
  end

  def to_s
    "[#{Time.at(@time).utc}] #{self.class.name}: #{@current_usage} W"
  end
end
