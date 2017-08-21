# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top_travel_destinations/version'

Gem::Specification.new do |spec|
  spec.name          = "top-travel-destinations"
  spec.version       = TopTravelDestinations::VERSION
  spec.authors       = ["Zenia Villa"]
  spec.email         = ["zavilla90@gmail.com"]
  spec.summary       = "Top Travel Destinations"
  spec.files         = ["lib/top_travel_destinations/cli.rb", "lib/top_travel_destinations/destination.rb", "lib/top_travel_destinations/scraper.rb", "bin/top-travel-destinations", "config/environment.rb"]
  spec.description   = "Provides details on Tripadvisor's Top 25 Travel Destinations"
  spec.homepage      = "https://github.com/zeniavilla/top-travel-destinations-cli-app"
  spec.license       = "MIT"

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end
  
  spec.executables   << 'top-travel-destinations'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
end
