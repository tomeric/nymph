namespace :nymph do
  desc "list all outdated gems that are used by this rails application"
  task :outdated => :environment do
    loaded   = Nymph::Gem.find_loaded
    outdated = loaded.reject { |g| !g.outdated? }
    puts outdated.map { |g| "#{g.name} (#{g.current_version} vs #{g.latest.current_version})"}.join("\n")
  end
end