control 'check-dot-net-3.5-installed' do
  impact 1.0
  title 'check dot net 3.5 installed'
  desc 'Check dot net 3.5 is installed'
  describe windows_feature('.NET Framework 3.5 Features') do
    it { should be_installed }
  end
end

control 'check-sql-server-installed' do
  impact 3.0
  title 'check sql server installed'
  desc 'Check sql server is installed'
  describe service('MSSQLSERVER') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'check-sql-server-olap-installed' do
  impact 1.0
  title 'check sql server olap installed'
  desc 'Check sql server olap is installed'
  describe service('MSSQLServerOLAPService') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'check-sql-browser-installed' do
  impact 1.0
  title 'check sql browser installed'
  desc 'Check sql browser is installed'
  describe service('SQLBrowser') do
    it { should be_installed }
  end
end

control 'check-report-server-installed' do
  impact 1.0
  title 'check report server installed'
  desc 'Check report server is installed'
  describe service('ReportServer') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'check-sql-server-agent-installed' do
  impact 1.0
  title 'check sql server agent installed'
  desc 'Check sql server agent is installed'
  describe service('SQLSERVERAGENT') do
    it { should be_installed }
  end
end
