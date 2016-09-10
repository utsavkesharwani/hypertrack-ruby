Gem::Specification.new do |spec|
  spec.name        = 'hypertrack'
  spec.version     = '0.0.1'
  spec.date        = '2016-09-01'
  spec.summary     = "HyperTrack!"
  spec.description = "Ruby wrapper around HyperTrack's API"
  spec.authors     = ["Utsav Kesharwani"]
  spec.email       = 'utsav.kesharwani@gmail.com'
  spec.files       = Dir['lib/*.rb'] + Dir['lib/hypertrack/*.rb'] + Dir['lib/hypertrack/api_operations/*.rb'] + Dir['lib/hypertrack/api_operations/common/*.rb']
  spec.homepage    = 'http://rubygems.org/gems/hypertrack'
  spec.license     = 'MIT'
end