require 'faraday'

module WS2Connection
  def self.authenticate(email, base64_image, user_agent)
    conn = Faraday.new(url: ENV['WS2_URL']) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    conn.headers[:user_agent] = user_agent

    response = conn.post "/users/verify/#{email}", image: base64_image

    { status: response.status, message: response.body['message'] }
  end
end
