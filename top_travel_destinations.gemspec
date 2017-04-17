# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative './lib/top_travel_destinations/version'

Gem::Specification.new do |spec|
  spec.name          = "top_travel_destinations"
  spec.version       = TopTravelDestinations::VERSION
  spec.authors       = ["Zenia Villa"]
  spec.email         = ["zavilla90@gmail.com"]
  spec.files         = ["lib/top_travel_destinations.rb", "lib/top_travel_destinations/cli.rb", "lib/top_travel_destinations/scraper.rb," "config/environment.rb"]
  spec.summary       = "Top Travel Destinations"
  spec.description   = "Provides details on Tripadvisor's Top 25 Travel Destinations"
  spec.homepage      = "https://github.com/zeniavilla/top-travel-destinations-cli-app"
  spec.license       = "MIT"
  spec.bindir        = "exe"
  spec.executables   = ["top-travel-destinations"]
  spec.require_paths = ["lib", "lib/top_travel_destinations"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
end
