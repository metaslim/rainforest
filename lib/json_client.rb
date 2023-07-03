require 'json'
require 'net/http'
require 'uri'

require_relative './node'

class JSONClient
  def self.query(url)
    uri = URI(url)

    req = Net::HTTP::Get.new(uri)
    req['Content-Type'] = 'application/json'
    req['Accept'] = 'application/json'

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    handle_response(res)
  rescue StandardError => e
    handle_error(e)
  end

  private

  def self.handle_response(response)
    return Node.new if response.nil?

    if response.is_a?(Net::HTTPSuccess)
      json = JSON.parse(response.body)
      Node.new(json['message'], json['follow'])
    else
      Node.new
    end
  end

  def self.handle_error(error)
    # Handle or log the error appropriately
    puts "An error occurred: #{error.message}"
    Node.new
  end
end
