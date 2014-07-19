namespace :app do

  desc "pass a file, get a solution for code night #3"
  task :solve, [:in_file, :out_file] => :environment do |t, args|
    iterations, cave = CaveFileParser.parse(args[:in_file])

    p = ProgressBar.create(:title => "Contemplating...", :total => iterations)

    final_cave = App.new.solve(iterations, cave) do
      p.increment
    end


    solution = CaveScorer.score(final_cave)
    File.write(args[:out_file], solution)
  end

end
