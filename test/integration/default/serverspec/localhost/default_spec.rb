require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS
 
describe command('which java') do
  it { should return_exit_status 0 }
end

describe command('ls /usr/local/android/sdk/platforms/android-17') do
  it { should return_exit_status 0 }
end
