# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..11\n"; }
END {print "not ok 1\n" unless $loaded;}
use File::MkTemp;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $string = File::MkTemp::mktemp('MkTemp_XXXXXX','./t/');
if ($string){
  print "ok 2\n";
}else{
  print "not ok 2\n";
}

if ($string eq 'MkTemp_XXXXXX'){
  print "not ok 3\n";
}else{
  print "ok 3\n";
}

my $fh = File::MkTemp::mkstemp('MkTemp_mkstemp_XXXXXX','./t/');
if ($fh){
  print "ok 4\n";
}else{
  print "not ok 4\n";
}

if (print $fh "Printing to fh\n"){
  print "ok 5\n";
}else{
  print "not ok 5\n"
}

if ($fh->close){
  print "ok 6\n";
}else{
  print "not ok 6\n";
}

my ($sfh,$tempfile) = File::MkTemp::mkstempt('MkTemp_mkstempt_XXXXXX','./t/');
if ($sfh){
  print "ok 7\n";
}else{
  print "not ok 7\n";
}

if (print $sfh $tempfile){
  print "ok 8\n";
}else{
  print "not ok 8\n"
}

if ($sfh->close){
  print "ok 9\n";
}else{
  print "not ok 9\n";
}

open(FH,"./t/$tempfile");

my @temphandle = <FH>;

if (@temphandle){
  print "ok 10\n";
}else{
  print "not ok 10\n";
}

if ($temphandle[0] eq $tempfile){
  print "ok 11\n";
}else{
  print "not ok 11\n";
}
