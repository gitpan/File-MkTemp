use ExtUtils::MakeMaker;
WriteMakefile(NAME => 'File::MkTemp',
	      SKIP => [qw(xs_c xs_o c_o dynamic static)],
	      VERSION => '1.0.0',
              clean => {FILES=>q[file*]});

package MY;
sub postamble {
	"\n\# Avoid make problems:\nstatic::\n\ndynamic::\n\n";
}

