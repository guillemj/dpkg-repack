#!/usr/bin/perl

use v5.40;

use Test::More;

eval q{
    use Test::Strict;
    $Test::Strict::TEST_WARNINGS = 1;
};
plan skip_all => 'Test::Strict required for testing syntax' if $@;

# XXX: Remove once https://github.com/manwar/Test-Strict/pull/37 gets released.
eval 'push @Test::Strict::MODULES_ENABLING_WARNINGS, "v5.40"';

my @files = qw(dpkg-repack.pl);

plan tests => scalar @files * 3;

for my $file (@files) {
    syntax_ok($file);
    strict_ok($file);
    warnings_ok($file);
}
