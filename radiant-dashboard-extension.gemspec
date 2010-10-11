require File.expand_path("../lib/radiant-dashboard-extension/version", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{radiant-dashboard-extension}
  s.version = RadiantDashboardExtension::VERSION
  s.platform = Gem::Platform::RUBY

  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["Jim Gay"]
  s.date = %q{2010-10-11}
  s.description = %q{Dashboard provides a way to see recent activity in Radiant, and allows extension developers to add to the interface with Radiant regions.}
  s.email = %q{jim@saturnflyer.com}
  s.extra_rdoc_files = ["README.md","HELP.md","HELP_designer.md"]
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/saturnflyer/radiant-dashboard-extension}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{Dashboard Extension for Radiant CMS}
  s.test_files = `git ls-files`.split("\n")
end

