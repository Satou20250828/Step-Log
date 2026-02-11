class HealthController < ActionController::Metal
  def show
    self.status = :ok
    self.content_type = "text/plain"
    self.response_body = "ok"
  end

  def favicon
    self.status = :no_content
    self.response_body = ""
  end
end
