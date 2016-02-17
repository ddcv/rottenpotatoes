Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "UNZGSuDsBQplUq1kHUB85ihbT", "b5Qh3rOuMppj78MKctGC5GZTbRzHu3lszC6kgahKZlpBqbyd4Q"
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end


