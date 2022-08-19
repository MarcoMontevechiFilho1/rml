# Symlink-fixer

Script for moving files while preserving symlinks. It also tries to preserve the relative paths in order to not break code scalability.
It hasnt been thoroughly tested, so use with care.

# Usage:

Until now, i have used it with main.sh being in the same folder as the file i want to move. I suspect i can just put main.sh i whatever folder i want so long as it is in $PATH and use it, but i havent tested it this way. Use like this:

1 - If you want to search all folders below your current folder for fixable symlinks:
  $./main.sh file_to_be_moved path_to_move_file
 
2 - If you want to search for specific folders:
  $./main.sh file_to_be_moved path_to_move_file folder_1_in_which_to_look folder_2_in_which_to_look #and so on...
  
You can search all your system with:

 $./main.sh file_to_be_moved path_to_move_file /
 
 but i havent tested this yet.
 
You can also just write a log of all found symlinks and exit without changing a thing.
