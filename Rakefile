require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'spec/translator'

desc 'Default: run unit tests.'
task :default => :spec

desc 'Test the ip_to_country plugin.'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb'] 
end

desc 'Generate documentation for the ip_to_country plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'IpToCountry'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
