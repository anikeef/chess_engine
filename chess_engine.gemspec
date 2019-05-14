Gem::Specification.new do |s|
  s.name = "chess_engine"
  s.summary = "Simple chess library that uses algebraic notation"
  s.description = "This library provides all the rules of the chess game. Also it provides a command line interface with serialization features"
  s.version = "0.0.8"
  s.author = "Anikeev Gennadiy"
  s.email = "genaydzhan70@gmail.com"
  s.homepage = "https://github.com/anikeef/chess"
  s.platform = Gem::Platform::RUBY
  s.executables = ["chess_engine"]
  s.required_ruby_version = '>=1.9'
  s.files = Dir["lib/**/**"]
  s.test_files = Dir["spec/*.rb"]
  s.has_rdoc = false
end
