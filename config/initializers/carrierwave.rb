CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.application.secrets.access_key,
    :aws_secret_access_key  => Rails.application.secrets.secret_key
  }

  config.fog_directory     = Rails.application.secrets.bucket
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
