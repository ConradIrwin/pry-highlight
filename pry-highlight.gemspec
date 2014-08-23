Gem::Specification.new do |s|
  s.name = "pry-highlight"
  s.version = "0.1.0"
  s.platform = Gem::Platform::RUBY
  s.author = "Conrad Irwin"
  s.email = "conrad.irwin@gmail.com"
  s.license = "MIT"
  s.homepage = "http://github.com/ConradIrwin/pry-highlight"
  s.summary = "Adds a >> command to pretty-print Strings"
  s.description = "Uses JSON, Nokogiri and CodeRay to highlight and prettify JSON, XML, HTML, Ruby and anything else CodeRay supports!"
  s.files = ["lib/pry-highlight.rb", "README.markdown", "LICENSE.MIT"]
  s.require_path = "lib"
  s.add_dependency 'pry'
  s.add_dependency 'json'
  s.add_dependency 'nokogiri'
  s.add_dependency 'coderay'
end
