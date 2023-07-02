require 'webmock/rspec'
require_relative '../rainforest'

SAMPLE_URL = 'https://www.letsrevolutionizetesting.com/challenge?id='
NOT_END_MESSAGE = 'This is not the end'
END_MESSAGE = 'Congratulations! You\'ve reached the end! You have passed our simple test and we would love to hear from you. Please save the code you used to a private GitHub gist and fill out the application form at https://jobs.lever.co/rainforest with the link to the gist. We\'ll be in touch shortly!'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "#{SAMPLE_URL}123").
    to_return(status: 200, body: response = {
      message: NOT_END_MESSAGE,
      follow: "#{SAMPLE_URL}456"
    }.to_json)

    stub_request(:get, "#{SAMPLE_URL}456").
    to_return(status: 200, body: response = {
      message: NOT_END_MESSAGE,
      follow: "#{SAMPLE_URL}789"
    }.to_json)

    stub_request(:get, "#{SAMPLE_URL}789").
    to_return(status: 200, body: response = {
      message: END_MESSAGE
    }.to_json)
  end
end

describe '#run' do
  let(:response) { run("#{SAMPLE_URL}123") }
  it 'return end message' do
    expect(response.message).not_to eq(NOT_END_MESSAGE)
    expect(response.message).to eq(END_MESSAGE)
  end
end
