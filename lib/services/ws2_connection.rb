require 'faraday'

module WS2Connection
  def self.authenticate(email, base64_image)
    conn = Faraday.new(url: ENV['WS2_URL']) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.post "/users/verify/#{email}", image: base64_image

    { status: response.status, message: response.body['message'] }
  end
end
