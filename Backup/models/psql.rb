Backup::Model.new(:psql, "Back up of psql db #{ENV['PSQL_DATABASE']}") do
  compress_with ENV.fetch('COMPRESSION', 'Gzip')
  notify_by Slack if ENV.key?('SLACK_URL')
  store_with FTP if ENV.key?('FTP_SERVER')
  store_with SFTP if ENV.key?('SFTP_SERVER')
  encrypt_with OpenSSL if ENV.key?('BACKUP_PASSWORD')

  database PostgreSQL do |db|
    db.name               = ENV['PSQL_DATABASE']
    db.username           = ENV['PSQL_USERNAME']
    db.password           = ENV['PSQL_PASSWORD']
    db.host               = ENV['PSQL_SERVER']
    db.port               = ENV.fetch('PSQL_PORT', 5432)
    db.additional_options = []
  end
end
