Pod::Spec.new do |spec|
  spec.name         = 'GitHubAPI'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/HeminWon/IssueHub'
  spec.authors      = { 'HeminWon' => 'heminwmh@gmail.com' }
  spec.summary      = '.'
  spec.source       = { :git => 'https://github.com/HeminWon/IssueHub.git', :tag => '#{s.version}' }
  spec.source_files = 'GitHubAPI/*.swift'
  spec.ios.deployment_target     = '11.0'
  spec.watchos.deployment_target = '3.0'
  spec.dependency 'Alamofire', '~> 4.7.3'
  spec.dependency 'Apollo', '~> 0.9.2'
end
