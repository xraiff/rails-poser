class ProxyController < ApplicationController

  require "net/http"

  def default
    Rails.logger.info "Here I am"
    #send_data 1, disposition: 'inline'
    result = Net::HTTP.get_response("0.0.0.0", request.env["REQUEST_URI"], 3000)
    @body = result.body
    render layout: false
  end
end
