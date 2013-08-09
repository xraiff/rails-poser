class ApplicationController < ActionController::Base

  def default
    Rails.logger.info "Here I am"
    #send_data 1, disposition: 'inline'
    result = Net::HTTP.get_response("0.0.0.0:3001", @request.env["REQUEST_URI"])
    render_text result.body
  end
end
