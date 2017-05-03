require 'faraday'
require 'json'

module WS2Connection
  def self.authenticate(email, base64_image, user_agent)
    conn = Faraday.new(url: ENV['WS2_URL']) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    conn.headers[:user_agent] = user_agent

    response = conn.post "/verify_user/#{email}", image: base64_image

    { status: response.status, message: JSON.parse(response.body)['message'] }
  end
end
