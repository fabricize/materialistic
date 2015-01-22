require 'spec_helper'
require 'pry-byebug'
require 'pp'

describe Materialistic, :vcr => true do
  it 'has a version number' do
    expect(Materialistic::VERSION).not_to be nil
  end

  it 'can list items' do
    result = Materialistic.list 'Arduino'
    expect(result.class).to eq(Array)
    pp result
  end

  it 'can fetch item details' do
    result = Materialistic.item switch_science: '790'
    expect(result.class).to eq(Hash)
  end
end
