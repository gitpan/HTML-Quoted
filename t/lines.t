use strict;
use warnings;

use Test::More tests => 8;
BEGIN { use_ok('HTML::Quoted') };

use Data::Dumper;
{
    my $a = "line1";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1'}]);
}

{
    my $a = "line1<br>";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br>'}])
        or diag Dumper(HTML::Quoted->extract($a));
}
{
    my $a = "line1<br />";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br />'}])
        or diag Dumper(HTML::Quoted->extract($a));
}
{
    my $a = "line1<br></br>";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br></br>'}])
        or diag Dumper(HTML::Quoted->extract($a));
}

{
    my $a = "line1<br>line2";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br>'}, {raw => 'line2'}])
        or diag Dumper(HTML::Quoted->extract($a));
}
{
    my $a = "line1<br />line2";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br />'}, {raw => 'line2'}]);
}
{
    my $a = "line1<br></br>line2";
    is_deeply(HTML::Quoted->extract($a),[{raw => 'line1<br></br>'}, {raw => 'line2'}]);
}

