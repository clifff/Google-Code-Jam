task :default => 'test'

# Assumes that if you have somethign like sample.in && sample.out or B-small-attempt0.in && B-small-attempt1.out, they are a valid pair
desc 'Tests your program!'
task :test do
  pwd = Rake.original_dir
  Dir.chdir(pwd)
  valid_tests = {}
  invalid_tests = {}

  # Determine the program filename
  files = Dir.entries(pwd)
  files = files.delete_if{|x| (x == '.' || x == '..') }
  prog = files.find{|x| x.index(/.rb$/) }

  files = Dir.glob("works/*")
  files = files.delete_if{|x| (x == '.' || x == '..') }

  # Look for the working files and add it to the map
  inputs = files.select{ |x| x.index(/.in$/) }
  inputs.each do |input|
    output = input.sub(".in", ".out")
    if files.include?(output)
      valid_tests[input] = output
    end
  end

  files = Dir.glob("fails/*")
  files = files.delete_if{|x| (x == '.' || x == '..') }

  # Look for the failing files and add it to the map
  inputs = files.select{ |x| x.index(/\d+.in$/) }
  inputs.each do |input|
    output = input.sub(".in", ".out")
    if files.include?(output)
      invalid_tests[input] = output
    end
  end
  
  ["/tmp/works", "/tmp/fails"].each do |dir|
    Dir.mkdir(dir) unless Dir.exists?(dir)
  end

  valid_tests.each do |input_name, output_name|
    # Read the output of the file
    reference_output = ""
    file = File.new(output_name, "r")
    while (line = file.gets)
      reference_output += line
    end
    file.close

    puts "Testing #{prog} against #{input_name}..."
    cmd = "ruby #{prog} #{input_name}"
    result = `#{cmd}`
    if result != reference_output
      File.open("/tmp/#{output_name}", 'w'){ |f| f.write(result)}
      print `diff /tmp/#{output_name} #{output_name}`
    else
      puts "Great success!"
    end
  end

  invalid_tests.each do |input_name, output_name|
    # Read the output of the file
    reference_output = ""
    file = File.new(output_name, "r")
    while (line = file.gets)
      reference_output += line
    end
    file.close

    puts "Testing #{prog} against #{input_name}..."
    cmd = "ruby #{prog} #{input_name}"
    result = `#{cmd}`
    if result != reference_output
      puts "Not a total failure!"
    else
      puts "FAIL. Current program matched a known bad output!"
    end
  end

end

desc "Takes one argument, creates a new folder for that problem w/ starting .rb file and test folders"
task :create do
  puts ARGV.inspect
  dir = ARGV[1]
  raise 'Error: must provide a problem to create!' unless dir

  if Dir.exists?(dir)
    puts "Directory #{dir} already exists"
  else
    Dir.mkdir(dir)
    puts "Created #{dir}"
  end

  filename = dir + "/" + dir + ".rb"

  if File.exists?(filename)
    puts "#{filename} already exists!"
  else
    program = <<END
ARGF.readline
count = 0
ARGF.each do |input|
  puts input
end
END
    File.open(filename, 'w'){ |f| f.write(program)}
    puts "Created #{filename}"
  end

  ["/works", "/fails"].each do |sub_dir|
    if Dir.exists?(dir + sub_dir)
      puts "Directory #{dir} already exists."
    else
      Dir.mkdir(dir + sub_dir)
      puts "Created #{dir}"
    end
  end

end
