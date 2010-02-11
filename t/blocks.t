use strict;
use warnings;

use Test::More tests => 4;
BEGIN { use_ok('HTML::Quoted') };

use Data::Dumper;
{
    my $a = "<div>line1</div>";
    is_deeply(HTML::Quoted->extract($a),[{raw => '<div>line1</div>', block => 1 }])
        or diag Dumper(HTML::Quoted->extract($a));
}
{
    my $a = "<div />";
    is_deeply(HTML::Quoted->extract($a),[{raw => '<div />', block => 1 }])
        or diag Dumper(HTML::Quoted->extract($a));
}
{
    my $a = "<div></div><br />";
    is_deeply(HTML::Quoted->extract($a),[{raw => '<div></div>', block => 1 },{raw => '<br />'}])
        or diag Dumper(HTML::Quoted->extract($a));
}
