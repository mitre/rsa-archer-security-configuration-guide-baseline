control 'rsa-archer-1.12' do
  title 'Account lockout period'
  desc 'Accounts locked due to unsuccessful logon attempts will stay locked
  until unlocked by an administrator.'
  impact 'medium'
  desc 'check', 'In security parameters, check if LockoutPeriod = 999.'
  desc 'fix', 'In security parameters, set LockoutPeriod = 999.'
  tag 'nist': ['AC-7', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.LockoutPeriod') { should cmp >= attribute('lockout_period') }
    its('general_user_parameter.LockoutPeriod') { should cmp >= attribute('lockout_period') }
    its('archer_services_parameter.LockoutPeriod') { should cmp >= attribute('lockout_period') }
  end
end
