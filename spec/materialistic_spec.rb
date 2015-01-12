require 'spec_helper'
require 'pp'

describe Materialistic do
  it 'has a version number' do
    expect(Materialistic::VERSION).not_to be nil
  end

  it 'Valid item' do
    result = Materialistic.find "LCD-10862"
    pp result
    expect(result.class).to eq(Array)
  end
end
