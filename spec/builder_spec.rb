require 'spec_helper'
require 'ostruct'

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
end
