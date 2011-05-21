task :default => 'test'

# Assumes that if you have somethign like sample.in && sample.out or B-small-attempt0.in && B-small-attempt1.out, they are a valid pair
desc 'Tests your program!'
task :test do
  tests = {}

  # Determine the program filename
  files = Dir.entries(Dir.pwd)
  files = files.delete_if{|x| (x == '.' || x == '..') }

  # First, freak out if the test stuff isn't there
  sample_in = files.find{|x| x.index('sample.in')}
  sample_out = files.find{|x| x.index('sample.out')}
  if sample_in.nil?
    puts "Error: sample.in not found!"
    exit
  elsif sample_out.nil?
    puts "Error: sample.out not found!"
    exit
  end
  tests[sample_in] = sample_out

  # Look for the small attempts to add to testes
  small_inputs = files.select{ |x| x.index(/small-attempt\d*.in/) }
  small_inputs.each do |small_input|
    small_output = small_input.sub(".in", ".out")
    if files.select{ |x| x.index(small_output) }
      tests[small_input] = small_output
    end
  end

  # Figure out what the actual program name is
  prog = files.find{|x| x.index(/.rb$/) }

  tests.each do |input_name, output_name|
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

end

desc "If it doesn't already exist, creates a barebone file for you to start with"
task :setup do
  filename = Dir.pwd.split("/").last + ".rb"

  if File.exists?(filename)
    puts "This file already exists!"
    exit
  end

  program = <<END
ARGF.readline
count = 0
ARGF.each do |input|
  puts input
end
END

  File.open(filename, 'w'){ |f| f.write(program)}
end
