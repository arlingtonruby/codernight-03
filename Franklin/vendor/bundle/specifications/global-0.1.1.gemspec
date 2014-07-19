# -*- encoding: utf-8 -*-
# stub: global 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "global"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Railsware LLC"]
  s.date = "2014-07-09"
  s.description = "Simple way to load your configs from yaml"
  s.email = "contact@railsware.com"
  s.homepage = "https://github.com/railsware/global"
  s.licenses = ["MIT"]
  s.rubyforge_project = "global"
  s.rubygems_version = "2.2.0"
  s.summary = "Simple way to load your configs from yaml"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 3.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_development_dependency(%q<rake>, ["~> 10.1.0"])
      s.add_development_dependency(%q<therubyracer>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0"])
    else
      s.add_dependency(%q<rspec>, [">= 3.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_dependency(%q<rake>, ["~> 10.1.0"])
      s.add_dependency(%q<therubyracer>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 2.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 3.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
    s.add_dependency(%q<rake>, ["~> 10.1.0"])
    s.add_dependency(%q<therubyracer>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 2.0"])
  end
end
