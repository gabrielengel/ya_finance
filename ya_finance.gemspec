Gem::Specification.new do |s|
  s.name        = "ya_finance"
  s.version     = "0.0.7"
  s.summary     = "Financial Information 2023 - reads from Yahoo Finances"
  s.description = "Financial Information consumer with CLI working in 2023 - reads from Yahoo Finances"
  s.authors     = ["Gabriel Fonseca Engel"]
  s.email       = "gabrielfengel@gmail.com"
  s.files       = Dir['lib/**/*'] + Dir['bin/*'] + %w(Gemfile)
  s.bindir      = 'bin'
  s.executables << 'yafin'
  s.homepage    = "https://rubygems.org/gems/ya_finance"
  s.license     = "MIT"
end
