#!/usr/bin/perl
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

use strict;
use warnings;

use Test::More;

plan skip_all => 'author test' if not $ENV{AUTHOR_TESTING};

eval q{
    use Test::Perl::Critic;
    1;
} or do {
    plan skip_all => 'requires module Test::Perl::Critic';
};

my @policies = qw(
    BuiltinFunctions::ProhibitBooleanGrep
    BuiltinFunctions::ProhibitLvalueSubstr
    BuiltinFunctions::ProhibitReverseSortBlock
    BuiltinFunctions::ProhibitSleepViaSelect
    BuiltinFunctions::ProhibitStringySplit
    BuiltinFunctions::ProhibitUniversalCan
    BuiltinFunctions::ProhibitUniversalIsa
    BuiltinFunctions::ProhibitUselessTopic
    BuiltinFunctions::ProhibitVoidGrep
    BuiltinFunctions::ProhibitVoidMap
    BuiltinFunctions::RequireBlockGrep
    BuiltinFunctions::RequireBlockMap
    BuiltinFunctions::RequireGlobFunction
    BuiltinFunctions::RequireSimpleSortBlock
    ClassHierarchies::ProhibitAutoloading
    ClassHierarchies::ProhibitExplicitISA
    ClassHierarchies::ProhibitOneArgBless
    CodeLayout::ProhibitHardTabs
    CodeLayout::ProhibitParensWithBuiltins
    CodeLayout::ProhibitQuotedWordLists
    CodeLayout::ProhibitTrailingWhitespace
    CodeLayout::RequireConsistentNewlines
    ControlStructures::ProhibitCStyleForLoops
    ControlStructures::ProhibitLabelsWithSpecialBlockNames
    ControlStructures::ProhibitMutatingListFunctions
    ControlStructures::ProhibitNegativeExpressionsInUnlessAndUntilConditions
    ControlStructures::ProhibitUntilBlocks
    Documentation::RequirePackageMatchesPodName
    Documentation::RequirePodSections
    InputOutput::ProhibitBarewordFileHandles
    InputOutput::ProhibitInteractiveTest
    InputOutput::ProhibitJoinedReadline
    InputOutput::ProhibitOneArgSelect
    InputOutput::ProhibitReadlineInForLoop
    InputOutput::ProhibitTwoArgOpen
    InputOutput::RequireBracedFileHandleWithPrint
    InputOutput::RequireCheckedOpen
    InputOutput::RequireEncodingWithUTF8Layer
    Miscellanea::ProhibitFormats
    Miscellanea::ProhibitTies
    Miscellanea::ProhibitUnrestrictedNoCritic
    Miscellanea::ProhibitUselessNoCritic
    Modules::ProhibitConditionalUseStatements
    Modules::ProhibitEvilModules
    Modules::RequireBarewordIncludes
    Modules::RequireEndWithOne
    Modules::RequireExplicitPackage
    Modules::RequireFilenameMatchesPackage
    NamingConventions::Capitalization
    Objects::ProhibitIndirectSyntax
    RegularExpressions::ProhibitEscapedMetacharacters
    RegularExpressions::ProhibitSingleCharAlternation
    RegularExpressions::ProhibitUnusedCapture
    RegularExpressions::ProhibitUnusualDelimiters
    RegularExpressions::ProhibitUselessTopic
    RegularExpressions::RequireBracesForMultiline
    RegularExpressions::RequireExtendedFormatting
    Subroutines::ProhibitExplicitReturnUndef
    Subroutines::ProhibitManyArgs
    Subroutines::ProhibitNestedSubs
    Subroutines::ProhibitReturnSort
    Subroutines::ProhibitUnusedPrivateSubroutines
    Subroutines::ProtectPrivateSubs
    TestingAndDebugging::ProhibitNoStrict
    TestingAndDebugging::ProhibitNoWarnings
    TestingAndDebugging::RequireTestLabels
    TestingAndDebugging::RequireUseStrict
    TestingAndDebugging::RequireUseWarnings
    ValuesAndExpressions::ProhibitCommaSeparatedStatements
    ValuesAndExpressions::ProhibitComplexVersion
    ValuesAndExpressions::ProhibitInterpolationOfLiterals
    ValuesAndExpressions::ProhibitLongChainsOfMethodCalls
    ValuesAndExpressions::ProhibitMismatchedOperators
    ValuesAndExpressions::ProhibitMixedBooleanOperators
    ValuesAndExpressions::ProhibitQuotesAsQuotelikeOperatorDelimiters
    ValuesAndExpressions::ProhibitSpecialLiteralHeredocTerminator
    ValuesAndExpressions::ProhibitVersionStrings
    ValuesAndExpressions::RequireConstantVersion
    ValuesAndExpressions::RequireQuotedHeredocTerminator
    ValuesAndExpressions::RequireUpperCaseHeredocTerminator
    Variables::ProhibitAugmentedAssignmentInDeclaration
    Variables::ProhibitConditionalDeclarations
    Variables::ProhibitLocalVars
    Variables::ProhibitMatchVars
    Variables::ProhibitPackageVars
    Variables::ProhibitPerl4PackageNames
    Variables::ProhibitUnusedVariables
    Variables::ProtectPrivateVars
    Variables::RequireLexicalLoopIterators
    Variables::RequireNegativeIndices
);

Test::Perl::Critic->import(
    -profile => 't/critic/perlcriticrc',
    -verbose => 8,
    -include => \@policies,
    -only => 1,
);

my @files = qw(dpkg-repack.pl);

plan tests => scalar @files;

for my $file (@files) {
    critic_ok($file);
}
