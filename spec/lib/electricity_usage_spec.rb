require_relative '../../lib/electricity_usage'

RSpec.describe ElectricityUsage do
  describe '.from_raw' do
    context 'with "meterData" broadcasts' do
      let(:message) do
        '*!{"trans":12345,"mac":"10:1A:A1","time":1590924768,"pkt":"123A",' \
          '"fn":"meterData","prod":"pwrMtr","serial":"12A3BC","type":"energy"' \
          ',"cUse":345,"todUse":3456}'
      end

      subject { described_class.from_raw(message) }

      it 'returns a new instance' do
        expect(subject).to be_a(described_class)
      end

      it 'correctly parses & assigns the data fields' do
        expect(subject.trans).to eq(12345)
        expect(subject.mac).to eq('10:1A:A1')
        expect(subject.time).to eq(1590924768)
        expect(subject.current).to eq(345)
        expect(subject.today).to eq(3456)
      end
    end

    context 'with broadcasts that are not relevant "meterData"' do
      messages = %w[
        *!{"trans":12345,"fn":"somethingElse"}
        !{"trans":12345}
        *?{"trans":12345,"fn":"somethingElse"}
        *?{"trans":12345}
        {"is":"this_thing_on"}
        *!{}
        *?{}
      ]

      messages.each do |message|
        it "returns nil for message: #{message}" do
          expect(described_class.from_raw(message)).to be_nil
        end
      end

      messages.each do |message|
        it "logs the ignored message to stdout for: #{message}" do
          expect {
            described_class.from_raw(message)
          }.to output("Ignoring message: #{message}\n").to_stdout
        end
      end
    end

    context 'with invalid or malformed broadcasts' do
      messages = %w[
        *!{
        *!
        *!{
        *?
        {
        banana
      ]

      messages.each do |message|
        it "returns nil for message: #{message}" do
          expect(described_class.from_raw(message)).to be_nil
        end
      end

      messages.each do |message|
        it "logs the invalid message to stdout for: #{message}" do
          expect {
            described_class.from_raw(message)
          }.to output("Invalid message: #{message}\n").to_stdout
        end
      end
    end
  end
end
