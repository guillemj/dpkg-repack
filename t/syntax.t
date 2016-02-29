#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

eval q{
    use Test::Strict;
    $Test::Strict::TEST_WARNINGS = 1;
};
plan skip_all => 'Test::Strict required for testing syntax' if $@;

my @files = qw(dpkg-repack);

plan tests => scalar @files * 3;

for my $file (@files) {
    syntax_ok($file);
    strict_ok($file);
    warnings_ok($file);
}
