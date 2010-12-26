# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_gl/version"

Gem::Specification.new do |s|
  s.name        = "simple_gl"
  s.version     = SimpleGl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Radev"]
  s.email       = ["andrey.radev@gmail.com"]
  s.homepage    = "http://github.com/AndrewRadev"
  s.summary     = %q{A gem that simplifies OpenGL coding for small tasks}
  s.description = %q{A gem that simplifies OpenGL coding for small tasks}

  s.rubyforge_project = "simple_gl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('ruby-opengl', '~> 0.60.1')
end
