#
# Cookbook Name:: sqlserver
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
powershell_script 'delete-install-directory' do
  code	<<-EOC
		Remove-Item "#{node['sqlserver']['install_directory']}" -Recurse -Force
        if ($? -eq $True)
		{
			exit 0;
		}
		if ($? -eq $False)
        {
			exit 2;
        }
		EOC
  guard_interpreter :powershell_script
  only_if { File.exist?(node['sqlserver']['install_directory']) }
end

directory 'C:/temp/' do
  rights :full_control, node['sqlserver']['service_account']
  inherits true
  action :create
  not_if { File.exist?('C:/temp') }
end

template 'C:/temp/ConfigurationFile.ini' do
  owner 'Administrator'
  group 'Administrator'
  mode '0644'
  only_if { File.exist?('C:/temp') }
end

powershell_script 'download-sqlserver-iso' do
  code <<-EOC
		$Client = New-Object System.Net.WebClient
		$Client.DownloadFile("#{node['sqlserver']['iso_url']}", "C:/temp/#{node['sqlserver']['iso_file']}")
		EOC
  guard_interpreter :powershell_script
  not_if { File.exist?("C:/temp/#{node['sqlserver']['iso_file']}") }
end

powershell_script 'mount-iso-file' do
  code <<-EOC
		Mount-DiskImage -ImagePath "C:/temp/#{node['sqlserver']['iso_file']}"
        if ($? -eq $True)
		{
			exit 0;
		}
		if ($? -eq $False)
        {
			exit 2;
        }
		EOC
  guard_interpreter :powershell_script
  not_if "((gwmi -class win32_LogicalDisk | Where-Object {$_.VolumeName -eq \"#{node['sqlserver']['volume_name']}\"}).VolumeName -eq \"#{node['sqlserver']['volume_name']}\")"
end

powershell_script 'install-sqlserver' do
  code <<-EOC
		$SQL_Server_ISO_Drive_Letter = (gwmi -Class Win32_LogicalDisk | Where-Object {$_.VolumeName -eq "#{node['sqlserver']['volume_name']}"}).DeviceID
		cd $SQL_Server_ISO_Drive_Letter
		./Setup.exe /SQLSVCPASSWORD="#{node['sqlserver']['service_account_password']}" /SAPWD="#{node['sqlserver']['system_admin_password']}" /CONFIGURATIONFILE=C:/temp/ConfigurationFile.ini /IACCEPTSQLSERVERLICENSETERMS
		EOC
  guard_interpreter :powershell_script
  not_if "((gwmi -class win32_service | Where-Object {$_.Name -eq \"#{node['sqlserver']['instance_name']}\"}).Name -eq \"#{node['sqlserver']['instance_name']}\")"
end

powershell_script 'dismount-iso-file' do
  code <<-EOC
		Dismount-DiskImage -ImagePath "C:/temp/#{node['sqlserver']['iso_file']}"
		EOC
  guard_interpreter :powershell_script
  only_if "((gwmi -class win32_LogicalDisk | Where-Object {$_.VolumeName -eq \"#{node['sqlserver']['volume_name']}\"}).VolumeName -eq \"#{node['sqlserver']['volume_name']}\")"
end

# powershell_script 'delete-iso-file' do
#   code <<-EOC
#		[System.IO.File]::Delete("C:/temp/#{node['sqlserver']['iso_file']}")
#	  EOC
#  guard_interpreter :powershell_script
#  only_if { File.exist?("C:/temp/#{node['sqlserver']['iso_file']}") }
# end
