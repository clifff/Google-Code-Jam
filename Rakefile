task :default => 'test'

# Assumes that if you have somethign like sample.in && sample.out or B-small-attempt0.in && B-small-attempt1.out, they are a valid pair
desc 'Tests your program!'
task :test do
  valid_tests = {}
  invalid_tests = {}

  # Determine the program filename
  files = Dir.entries(Dir.pwd)
  files = files.delete_if{|x| (x == '.' || x == '..') }
  prog = files.find{|x| x.index(/.rb$/) }

  Dir.chdir(Dir.pwd + "/works")
  files = Dir.entries(Dir.pwd)
  files = files.delete_if{|x| (x == '.' || x == '..') }

  # Look for the working files and add it to the map
  inputs = files.select{ |x| x.index(/.in/) }
  inputs.each do |input|
    output = input.sub(".in", ".out")
    if files.include?(output)
      valid_tests["works/" + input] = "works/" + output
    end
  end

  Dir.chdir(Dir.pwd + "/../fails")
  files = Dir.entries(Dir.pwd)
  files = files.delete_if{|x| (x == '.' || x == '..') }
  Dir.chdir("../")

  # Look for the failing files and add it to the map
  inputs = files.select{ |x| x.index(/\d+.in/) }
  inputs.each do |input|
    output = input.sub(".in", ".out")
    if files.include?(output)
      invalid_tests["fails/" + input] = "fails/" + output
    end
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

desc "If it doesn't already exist, creates a barebone file for you to start with"
task :setup do
  filename = Dir.pwd.split("/").last + ".rb"

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

  ["/works", "/fails"].each do |dir|
    if Dir.exists?(pwd + dir)
      puts "Directory #{dir} already exists."
    else
      Dir.mkdir(pwd + dir)
      puts "Created #{dir}"
    end
  end

end
