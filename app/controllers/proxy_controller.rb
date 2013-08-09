class ProxyController < ApplicationController

  require "net/http"

  def default
    #send_data 1, disposition: 'inline'
    result = Net::HTTP.get_response("0.0.0.0", request.env["REQUEST_URI"], 3000)
    Rails.logger.info "result.code = #{result.code}"
    if result.code == 302 or result.code == 301
      result = Net::HTTP.get_response(URI.parse(result.header['location']))
    end
    @body = result.body
    render layout: false
  end
end
