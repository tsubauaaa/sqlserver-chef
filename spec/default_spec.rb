require 'chefspec'

RSpec.configure do |config|
  config.platform = 'windows'
  config.version = '2012R2'
end

describe 'sqlserver::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
  before do
    stub_command("((gwmi -class win32_LogicalDisk | Where-Object {$_.VolumeName -eq \"SQL2014_x64_JPN\"}).VolumeName -eq \"SQL2014_x64_JPN\")").and_return(false)
    stub_command("((gwmi -class win32_service | Where-Object {$_.Name -eq \"MSSQLSERVER\"}).Name -eq \"MSSQLSERVER\")").and_return(false)
  end
  it 'runs a powershell_script with delete install directory' do
    allow(File).to receive(:exist?).and_return(true)
    expect(chef_run).to run_powershell_script('delete-install-directory')
  end
  it 'creates a temp directory' do
    expect(chef_run).to create_directory('C:/temp/').with(rights: [{ permissions: :full_control, principals: 'NT Service\MSSQLSERVER' }])
  end
  it 'creates a ConfigurationFile template' do
    allow(File).to receive(:exist?).and_return(true)
    expect(chef_run).to create_template('C:/temp/ConfigurationFile.ini').with(
      user:   'Administrator',
      group:  'Administrator',
      mode: '0644'
    )
  end
  it 'creates a cookbook_file with iso file' do
    expect(chef_run).to create_cookbook_file('C:/temp/SQLServer2014SP1-FullSlipstream-x64-JPN.iso')
  end
  it 'runs a powershell_script with mount iso file' do
    expect(chef_run).to run_powershell_script('mount-iso-file')
  end
  it 'runs a powershell_script with install sqlserver' do
    expect(chef_run).to run_powershell_script('install-sqlserver')
  end
  it 'runs a powershell_script with dismount iso file' do
    stub_command("((gwmi -class win32_LogicalDisk | Where-Object {$_.VolumeName -eq \"SQL2014_x64_JPN\"}).VolumeName -eq \"SQL2014_x64_JPN\")").and_return(true)
    expect(chef_run).to run_powershell_script('dismount-iso-file')
  end
end
