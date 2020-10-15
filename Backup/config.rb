##
# Backup v4.x Configuration
# Main Config Template
#
# Documentation: http://meskyanichi.github.io/backup
# Issue Tracker: https://github.com/meskyanichi/backup/issues

data_path '/data'

if ENV.key?('FTP_SERVER')
  Storage::FTP.defaults do |server|
    server.username     = ENV['FTP_USERNAME']
    server.password     = ENV['FTP_PASSWORD']
    server.ip           = ENV['FTP_SERVER']
    server.port         = ENV['FTP_PORT']
    server.path         = ENV['FTP_PATH']
    server.passive_mode = true
    server.timeout      = 10
    server.keep         = ENV.fetch('FTP_KEEP', 1)
  end
end

if ENV.key?('SFTP_SERVER')
  Storage::SFTP.defaults do |server|
    server.username     = ENV['SFTP_USERNAME']
    server.password     = ENV['SFTP_PASSWORD']
    server.ip           = ENV['SFTP_SERVER']
    server.port         = ENV['SFTP_PORT']
    server.path         = ENV['SFTP_PATH']
    server.keep         = ENV.fetch('SFTP_KEEP', 1)
    server.ssh_options = { user_known_hosts_file: "/dev/null" }
  end
end

if ENV.key?('SLACK_URL')
  Notifier::Slack.defaults do |slack|
    slack.on_success = (ENV.fetch('SLACK_NOTIFY_SUCCESS', true).to_s == 'true')
    slack.on_warning = (ENV.fetch('SLACK_NOTIFY_WARNING', true).to_s == 'true')
    slack.on_failure = (ENV.fetch('SLACK_NOTIFY_FAILURE', true).to_s == 'true')

    slack.webhook_url = ENV['SLACK_URL']
  end
end

if ENV.key?('BACKUP_PASSWORD')
  Encryptor::OpenSSL.defaults do |encryption|
    encryption.password = ENV['BACKUP_PASSWORD']
    encryption.base64   = true
    encryption.salt     = true
  end
end