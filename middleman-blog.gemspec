# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-blog/version"

Gem::Specification.new do |s|
  s.name        = "middleman-blog"
  s.version     = Middleman::Blog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matthias Döring"]
  s.email       = ["matt@foryourcontent.de"]
  s.homepage    = "http://rubygems.org/gems/middleman-blog"
  s.summary     = %q{Create a blog with Middleman}
  s.description = %q{Create a blog with Middleman}

  s.rubyforge_project = "middleman-blog"

  s.add_dependency "middleman", "~> 1.2.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
