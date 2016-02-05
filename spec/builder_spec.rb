require 'spec_helper'

RSpec.describe Julia::Builder do
  let(:dob){ Time.now }
  let(:query) do
    [
      OpenStruct.new({
        name:      'steven',
        last_name: 'barragan',
        dob: dob
      })
    ]
  end

  class Test1 < described_class
    column :name
  end

  class Test2 < described_class
    column 'Birthday', :dob
  end

  class Test3 < described_class
    column 'Full name', -> { "#{ name.capitalize } #{ last_name.capitalize }"}
  end

  context 'with header name equals to value' do
    let(:subject){ Test1.new(query) }

    it { expect(subject.build).to eq "name\nsteven\n" }
  end

  context 'with header different than the value' do
    let(:subject){ Test2.new(query) }

    it { expect(subject.build).to eq "Birthday\n#{ dob }\n" }
  end

  context 'with header different than the value' do
    let(:subject){ Test3.new(query) }

    it { expect(subject.build).to eq "Full name\nSteven Barragan\n" }
  end

  context 'with csv options' do
    let(:csv_options){ {col_sep: ','} }
    let(:subject){ Test1.new(query, csv_options) }

    it 'pass csv options' do
      expect(CSV).to receive(:generate).with csv_options

      subject.build
    end
  end

  context 'given a block' do
    class Test < described_class
      column 'Capital name' do |user|
        user.name.capitalize
      end
    end

    let(:subject){ Test.new(query) }

    it { expect(subject.build).to eq "Capital name\nSteven\n" }
  end

  describe '.column' do
    let(:block) { ->{ name } }

    it 'creates an action' do
      described_class.column(:key, :value, &block)

      columns = described_class.columns_config
      expect(columns).to be_include :key

      action = columns[:key]

      expect(action.key).to eq :key
      expect(action.action).to eq :value
      expect(action.block).to eq block
    end
  end

  describe '.columns' do
    it 'set up each column' do
      expect(described_class).to receive(:column).with :name
      expect(described_class).to receive(:column).with :lastname

      described_class.columns(:name, :lastname)
    end
  end

  describe '.build' do
    let(:builder){ double('builder') }

    it 'creates a new intance and calls build' do
      expect(described_class).to receive(:new).with(query, {}).and_return builder
      expect(builder).to receive(:build)

      Test1.build(query)
    end
  end
end
