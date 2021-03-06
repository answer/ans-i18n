# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ans-i18n/version"

Gem::Specification.new do |s|
  s.name        = "ans-i18n"
  s.version     = Ans::I18n::VERSION
  s.authors     = ["sakai shunsuke"]
  s.email       = ["sakai@ans-web.co.jp"]
  s.homepage    = "https://github.com/answer/ans-i18n"
  s.summary     = %q{i18n 関連のユーティリティー}
  s.description = %q{i18n 関連のユーティリティーを提供}

  s.rubyforge_project = "ans-i18n"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_development_dependency "ans-gem-builder"
end
