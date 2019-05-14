Gem::Specification.new do |s|
  s.name = "chess-engine"
  s.summary = "Simple chess library that uses algebraic notation"
  s.description = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.version = "0.0.1"
  s.author = "Anikeev Gennadiy"
  s.email = "genaydzhan70@gmail.com"
  s.homepage = "https://github.com/anikeef/chess"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9'
  s.files = Dir['**/**']
  s.test_files = Dir["spec/*.rb"]
  s.has_rdoc = false
end
