guard :bundler do
  watch('Gemfile')
end

guard 'puma', port: 5000, config: 'config/puma.rb' do
  watch('Gemfile.lock')
  watch(%r{^config|lib|api/.*})
end

group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec spring rspec', all_on_start: true do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/rails_helper.rb')  { "spec" }
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_#{m[2]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }
    watch('spec/rails_helper.rb')                       { "spec" }
    watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }
  end

  guard :rubocop, cli: '--rails' do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard 'brakeman', :run_on_start => true do
    watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
    watch(%r{^config/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch('Gemfile')
  end
end