#Everyones perl location is different so just do perl MkTempTest.pl
############################################################################
#program: MkTempTest.pl
#purpose: To test the MkTemp module.  If it returns a dup something isn't 
#         working.  This has been tested with up to 500000 files. All it 
#         does is make 50 empty files in the /tmp dir and tests to see if
#         it gets a dup. ls /tmp/file*|wc -l should return 50. Just do an
#         rm /tmp/file* to clean up.
#files:   MkTempTest.pl - main program
#dir:     /tmp - temp directory found on most UNIX systems
#by: Travis Gummels
#date: Mar 10 1999
############################################################################

use File::MkTemp;
use Cwd;

$dir = cwd(); 

$string = mktemp('fileXXXXXX',$dir);

$hash{$string} = 1;

for ($i = 0; $i < 50; $i++){
   $oldstr = $string;
   $string = mktemp('fileXXXXXX',$dir);
   $file = $dir . "/" . $string;

   if (-e $file){
      print "FounD dUP\t $i $file\n";
   }

   open (F,">$file");
   close(F);
}
