Gem::Specification.new do |gem|
  gem.authors       = ["Sean Porter"]
  gem.email         = ["portertech@gmail.com"]
  gem.description   = "Chef report handler to send metrics to x"
  gem.summary       = "Chef report handler to send metrics to x"
  gem.homepage      = "https://github.com/portertech/chef-metrics"

  gem.files         = `git ls-files`.split($\)
  gem.name          = "chef-metrics"
  gem.require_paths = ["lib"]
  gem.version       = "1.0.0"
end
