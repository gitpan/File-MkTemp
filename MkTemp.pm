# File/MkTemp.pm. Written in 1999 by Travis Gummels.
# If you find problems with this please let me know.
# travis.gummels@usa.net

package File::MkTemp;

require Exporter;

use File::Spec::Functions;
use Carp;

@ISA=qw(Exporter);
@EXPORT=qw(mktemp);
@EXPORT_OK=qw(mktemp);

$File::MkTemp::VERSION = '1.0.1';

sub VERSION {
    # Version of File::MkTemp
    return $File::MkTemp::VERSION;
}

sub mktemp {
    croak("Usage: mktemp('templateXXXXXX',['dir']) ") 
      unless(@_ == 1 || @_ == 2);

    my ($template,$dir) = @_;
    my @template = split //, $template;

    croak("The template must end with at least 6 uppercase letter X")
      if (substr($template, -6, 6) ne 'XXXXXX');

    if ($dir){
       croak("The directory in which you wish to test for duplicates, $dir, does not exist")
         unless (-e $dir);
    }

    my @letters = split(//,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");

    my $keepgen = 1;

    while ($keepgen){
       for ($i = $#template; $i >= 0 && ($template[$i] eq 'X'); $i--){
          $template[$i] = $letters[int(rand 52)];
       }

       undef $template;

       $template = pack "a" x @template, @template;

          if ($dir){
             my $lookup = catfile($dir, $template);
             $keepgen = 0 unless (-e $lookup);
          }else{
             $keepgen = 0;
          }

    next if $keepgen = 0;
    }

    return($template);
}
1;

__END__

=head1 NAME

File::MkTemp - Make temporary filename from template

=head1 SYNOPSIS

  	use File::MkTemp;

	mktemp(tempXXXXXX,[dir]);

	$string = mktemp(tempXXXXXX,[dir]);
	open(F,$string);

=head1 DESCRIPTION

The MkTemp module provides the function mktemp() which returns a unique
string which you can use to make unique files or directories with.  It
is based on the mktemp function found in c.  

The mktemp function takes one or two parameters. The first param is a 
template with at least 6 uppercase letter X at the end of the string. The
second optional param is the directory in which to test for duplicates.

=head1 AUTHOR

File::MkTemp was written by Travis Gummels.
Please send bug reports and or comments to: travis.gummels@usa.net

=head1 COPYRIGHT

Copyright 1999, Travis Gummels.  All rights reserved.  This may be 
used and modified however you want.  If you redistribute after making 
modifications please note modifications you made somewhere in the
distribution.

=cut
