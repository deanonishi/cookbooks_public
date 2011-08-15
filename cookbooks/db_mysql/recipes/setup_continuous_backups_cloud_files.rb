log "Enabling continuous backups to RackSpace CloudFiles via cron job: Minute:#{node[:db_mysql][:backup][:cron_backup_minute]} Hour:#{node[:db_mysql][:backup][:cron_backup_hour]}"

raise "ERROR: missing cron_backup_minute value." if node[:db_mysql][:backup][:cron_backup_minute].empty?
raise "ERROR: missing cron_backup_hour value." if node[:db_mysql][:backup][:cron_backup_hour].empty?
raise "ERROR: 'Backup Lineage' required for scheduled process" if node[:db_mysql][:backup][:lineage].empty?
raise "ERROR: 'Backup Storage Type' required for scheduled process" if node[:db_mysql][:backup][:storage_type].empty?

cron "RightScale continuous backups CloudFiles" do
  minute "#{node[:db_mysql][:backup][:cron_backup_minute]}"
  hour "#{node[:db_mysql][:backup][:cron_backup_hour]}"
  user "root"
  command "rs_run_recipe -n \"db_mysql::do_backup_cloud_files\" 2>&1 > /var/log/rightscale_tools_cron_backup.log"
  action :create
end