require 'spec_helper'
require 'activerecord_helper'

RSpec.describe 'Julia works with active record' do
  before :all do
    User.create name: 'Steven', last_name: 'Barragan', dob: Date.new(1990, 11, 19)
  end

  context 'given column equal to value' do
    class Test < Julia::Builder
      column :name
    end

    it { expect(Test.new(User.all).build).to eq "name\nSteven\n"}
  end

  context 'given column name and a value' do
    class Test1 < Julia::Builder
      column 'Birthday', :dob
    end

    it { expect(Test1.new(User.all).build).to eq "Birthday\n1990-11-19\n" }
  end

  context 'given a lambda' do
    class Test2 < Julia::Builder
      column 'Full name', -> { "#{ name.capitalize } #{ last_name.capitalize }"}
    end

    it { expect(Test2.new(User.all).build).to eq "Full name\nSteven Barragan\n" }
  end

  context 'given a block' do
    class Test3 < Julia::Builder
      column 'Class name' do |user|
        user.class.name
      end
    end

    it { expect(Test3.new(User.all).build).to eq "Class name\nUser\n" }
  end
end
