use strict;
use warnings;

use Test::More tests => 1;
use HTML::Quoted;
use Data::Dumper;

sub check {
    my ($html, $expected) = @_;
    my $res = HTML::Quoted->extract($html);
    is_deeply( $res, $expected, 'correct parsing')
        or diag Dumper($res);
}

{
    my $text = q{Hi,<div><br><div>On date X wrote:<br><blockquote>Hello,<div>How are you?</div></blockquote><div>I&#39;m fine.</div><blockquote><div>Where have you been?</div></blockquote><div>Around.</div></div></div>};

    my $res = [
           {
             'raw' => 'Hi,'
           },
           {
             'block' => 1,
             'raw' => '<div><br><div>On date X wrote:<br>'
           },
           [
             {
               'quote' => 1,
               'block' => 1,
               'raw' => '<blockquote>'
             },
             {
               'raw' => 'Hello,'
             },
             {
               'block' => 1,
               'raw' => '<div>How are you?</div>'
             },
             {
               'raw' => '</blockquote>'
             }
           ],
           {
             'block' => 1,
             'raw' => '<div>I&#39;m fine.</div>'
           },
           [
             {
               'quote' => 1,
               'block' => 1,
               'raw' => '<blockquote>'
             },
             {
               'block' => 1,
               'raw' => '<div>Where have you been?</div>'
             },
             {
               'raw' => '</blockquote>'
             }
           ],
           {
             'block' => 1,
             'raw' => '<div>Around.</div></div></div>'
           }
         ];

    check( $text, $res );
}
