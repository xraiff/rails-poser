class ProxyController < ApplicationController

  require "net/http"

  def default
    #send_data 1, disposition: 'inline'
    result = Net::HTTP.get_response("0.0.0.0", request.env["REQUEST_URI"], 3000)
    Rails.logger.info "result.headers = #{result.headers.to_s}"
    result = filter_responses(result)
    @body = result.body
    render layout: false
  end

  def filter_responses(result)
    if result.code == 302 or result.code == 301
      result = Net::HTTP.get_response(URI.parse(result.header['location']))
    elsif result.body == '<html><body>You are being <a href="http://0.0.0.0:3000/user/login">redirected</a>.</body></html>'
       result = Net::HTTP.get_response("0.0.0.0", "/user/login", 3000)
    end
    result
  end
end
