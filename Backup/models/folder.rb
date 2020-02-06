Backup::Model.new(:folder, "backup of #{ENV['BACKUP_FOLDER']}") do
  compress_with ENV.fetch('COMPRESSION', 'Gzip')
  notify_by Slack if ENV.key?('SLACK_URL')
  store_with FTP if ENV.key?('FTP_SERVER')
  store_with SFTP if ENV.key?('SFTP_SERVER')
  encrypt_with OpenSSL if ENV.key?('BACKUP_PASSWORD')

  archive :archive do |archive|
    ENV['BACKUP_FOLDER'].split(',').each do |folder|
      archive.add "#{folder}"
    end
  end
end
