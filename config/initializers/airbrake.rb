if Rails.env.production? && ENV['errbit_key']
  Airbrake.configure do |config|
    config.api_key = ENV['errbit_key']
    config.host    = 'errors.studentlife.org.nz'
    config.port    = 80
    config.secure  = config.port == 443
  end
end
