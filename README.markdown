# Warning
Any and all of these programs are probably really awful solutions to these problems, and should only be referenced for what not to do. The README in each project folder should warn you if they are correct or not.

# Rake Tools

## rake create
To start on a new problem, run 'rake create new_problem_name'. This will
create a new folder for that problem, and stub out the main Ruby file.
It will also create subfolders called "works" and "fails".


## rake test
Running "rake test" will try and test your program against known good
and bad input. To do this, add pairs of files to "works" or "fails" such
as "sample0.in" and "sample0.out"

When rake test runs, it will ensure that your program matches known good
output in the "works" folder, and doesn't match any known bad output in
the "fails" folder.
