Gem::Specification.new do |s|
  s.name = 'confucius'
  s.version = '0.0.1'
  s.authors = ['Victor Shepelev']
  s.email = 'zverok.offline@gmail.com'
  s.description = <<-EOF
    Simple, framework-agnostic library, incapsulating config initalization.
  EOF
  s.summary = 'Simple framework-agnostic configuration for any Ruby app'
  s.homepage = 'http://github.com/zverok/confucius'
  s.licenses = ['MIT']

  s.files = `git ls-files`.split($RS).reject do |file|
    file =~ /^(?:
    spec\/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.rubocop_todo.yml
    |\.travis.yml
    |.*\.eps
    )$/x
  end
  s.executables = s.files.grep(/^bin\//) { |f| File.basename(f) }
  
  s.require_paths = ["lib"]
  s.rubygems_version = '2.2.2'
  
  s.add_development_dependency 'bundler'
end
