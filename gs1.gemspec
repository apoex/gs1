lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gs1/version'

Gem::Specification.new do |spec|
  spec.name          = 'gs1'
  spec.version       = GS1::VERSION
  spec.authors       = ['Stefan Åhman']
  spec.email         = ['stefan.ahman@apoex.se']

  spec.summary       = 'A ruby gem for implementing GS1 standards'
  spec.description   = 'GS1 defines a set of GS1 standards directly from the documentation'
  spec.homepage      = 'https://github.com/apoex/gs1'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .filter { _1.start_with?('lib') } +
      %w[gs1.gemspec CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md]
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0.5'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
