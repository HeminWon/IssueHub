Pod::Spec.new do |spec|
  spec.name         = 'FlatCache'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/HeminWon/IssueHub'
  spec.authors      = { 'HeminWon' => 'heminwmh@gmail.com' }
  spec.summary      = 'In memory flat cache.'
  spec.source       = { :git => 'https://github.com/HeminWon/IssueHub.git', :tag => '#{s.version}' }
  spec.source_files = 'FlatCache/*.swift'
  spec.platform     = :ios, '11.0'
  spec.swift_version = '4.0'
end
