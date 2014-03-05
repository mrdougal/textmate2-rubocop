# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ast"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Zotov"]
  s.date = "2013-06-17"
  s.description = "A library for working with Abstract Syntax Trees."
  s.email = ["whitequark@whitequark.org"]
  s.homepage = "http://github.com/whitequark/ast"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "A library for working with Abstract Syntax Trees."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<bacon>, ["~> 1.2"])
      s.add_development_dependency(%q<bacon-colored_output>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<kramdown>, [">= 0"])
    else
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<bacon>, ["~> 1.2"])
      s.add_dependency(%q<bacon-colored_output>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<kramdown>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<bacon>, ["~> 1.2"])
    s.add_dependency(%q<bacon-colored_output>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<kramdown>, [">= 0"])
  end
end
