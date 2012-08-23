require 'rubygems'
require 'filewatcher'

filenames = ["unit/action_object_test.rb",
             "unit/action_test.rb",
             "unit/animation_test.rb",
             "unit/movement_test.rb",
             "unit/vector2d_test.rb"]
FileWatcher.new(filenames).watch(0.5) do |filename|
  filenames.each do |file|
    print "\e[2J\e[f"
    puts "Reloading #{file}"
    load(file)
    MiniTest::Unit.new.run_tests
  end
end