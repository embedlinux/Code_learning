lab11_regmodel - generation

This lab uses Cadence's iregGen tool to convert an IP-XACT XML register
specification into a UVM register model.

iregGen requires Perl and looks for a Perl installation directory in $PATH. 

iregGen also requires the Perl XML libraries.

if you get the following error, it means your Perl installation may not have
the XML libraries.

    iregGen Error: ‘can’t locate XML/LibXML.pm’.

You might find that you need to download the Perl XML libraries from CPAN.org,
as some Perl installations don't have the XML libs as standard.
If that's the case, you can leave PATH as it is, and simply point PERL5LIB env
var to the place that you downloaded and unpacked the XML libraries.

