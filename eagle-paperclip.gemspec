# -*- encoding: utf-8 -*-
require File.expand_path('../lib/eagle-paperclip/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Oleg German", "Yuri Gomozov"]
  gem.email         = ["ogerman@dultonmedia.com"]
  gem.description   = %q{EaglePlatform specific paperclip storage client}
  gem.summary       = %q{Add to your Gemfile and use!}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "eagle-paperclip"
  gem.require_paths = ["lib"]
  gem.version       = Eagle::Paperclip::VERSION

  gem.add_runtime_dependency "paperclip"
end
