require 'faraday'

module WS2Connection
  def self.authenticate(email, base64_image)
    conn = Faraday.new(url: ENV['WS2_URL']) { |farad| farad.response :logger }
    response = conn.post "/verify_user/#{email}", image: base64_image
    { status: response.status, message: response.message }
  end
end
