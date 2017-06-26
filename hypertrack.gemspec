require './version'

Gem::Specification.new do |spec|
  spec.name        = 'hypertrack'
  spec.version     = HyperTrack::VERSION
  spec.date        = '2017-06-26'
  spec.summary     = "Ruby bindings for the HyperTrack API!"
  spec.description = "Ruby wrapper around HyperTrack's API. Refer http://docs.hypertrack.com/ for more information."
  spec.authors     = ["Utsav Kesharwani", "Amit Rathi"]
  spec.email       = 'utsav.kesharwani@gmail.com, amit@hypertrack.io'
  spec.files       = Dir.glob('lib/**/*.rb')
  spec.homepage    = 'http://rubygems.org/gems/hypertrack'
  spec.license     = 'MIT'

  spec.add_dependency 'json', '~> 1.8'
  spec.required_ruby_version = '>= 2.0.0'
end