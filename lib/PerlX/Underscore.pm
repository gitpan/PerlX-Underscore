package PerlX::Underscore;
#ABSTRACT: Common helper functions without having to import them


use strict;
use warnings;
no warnings 'once';
use version ();

our $VERSION = version::qv('v0.1.0');

use Scalar::Util    1.36        ();
use List::Util      1.35        ();
use List::MoreUtils 0.07        ();
use Carp                        ();
use Safe::Isa       1.000000    ();


BEGIN {
    # check if a competing "_" exists
    if (keys %{_::}) {
        Carp::confess qq(The package "_" has already been defined);
    }
}

BEGIN {
    # prevent other "_" packages from being loaded:
    # Just setting the ${INC} entry would fail too silently,
    # so we also rigged the "import" method.
    
    $INC{'_.pm'} = *_::import = sub {
        Carp::confess qq(The "_" package is internal to PerlX::Underscore)
                    . qq(and must not be imported directly.\n);
    };
}



*_::class   = \&Scalar::Util::blessed;
*_::blessed = \&Scalar::Util::blessed;

*_::ref_addr = \&Scalar::Util::refaddr;

*_::ref_type = \&Scalar::Util::reftype;

*_::ref_weaken = \&Scalar::Util::weaken;

*_::ref_unweaken = \&Scalar::Util::unweaken;

*_::ref_is_weak = \&Scalar::Util::isweak;


*_::reduce = \&List::Util::reduce;

*_::any = \&List::Util::any;

*_::all = \&List::Util::all;

*_::none = \&List::Util::none;

*_::first = \&List::MoreUtils::first_value;

*_::first_index = \&List::MoreUtils::first_index;

*_::last = \&List::MoreUtils::last_value;

*_::last_index = \&List::MoreUtils::last_index;

*_::max     = \&List::Util::max;
*_::max_str = \&List::Util::maxstr;

*_::min     = \&List::Util::min;
*_::min_str = \&List::Util::minstr;

*_::sum = \&List::Util::sum;

*_::product = \&List::Util::product;

*_::pairgrep = \&List::Util::pairgrep;

*_::pairfirst = \&List::Util::pairfirst;

*_::pairmap = \&List::Util::pairmap;

*_::shuffle = \&List::Util::shuffle;

*_::natatime = \&List::MoreUtils::natatime;

*_::zip = \&List::MoreUtils::zip;

*_::uniq = \&List::MoreUtils::uniq;

*_::part = \&List::MoreUtils::part;


*_::carp = \&Carp::carp;

*_::cluck = \&Carp::cluck;

*_::croak = \&Carp::croak;

*_::confess = \&Carp::confess;


*_::isa = $Safe::Isa::_isa;

*_::does = $Safe::Isa::_DOES;

*_::can = $Safe::Isa::_can;

*_::safecall = $Safe::Isa::_call_if_object;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

PerlX::Underscore - Common helper functions without having to import them

=head1 VERSION

version v0.1.0

=head1 SYNOPSIS

    use PerlX::Underscore;
    
    _::croak "$foo must do Some::Role" if not _::does($foo, 'Some::Role');

=head1 DESCRIPTION

This module contains various utility functions, and makes them accessible through the C<_> package.
This allows the use of these utilities (a) without much per-usage overhead and (b) without namespace pollution.

It contains functions from the following modules:

=over 4

=item *

L<Scalar::Util>

=item *

L<List::Util>

=item *

L<List::MoreUtils>

=item *

L<Carp>

=item *

L<Safe::Isa>, which contains convenience functions for L<UNIVERSAL>

=back

Not all functions from those are available, and some have been renamed.

=head1

=head1 FUNCTION REFERENCE

=head2 Scalar::Util

=over 4

=item _::blessed $object

=item _::class $object

wrapper for C<Scalar::Util::blessed>

=item _::ref_addr $ref

wrapper for C<Scalar::Util::refaddr>

=item _::ref_type $ref

wrapper for C<Scalar::Util::reftype>

=item _::ref_weaken $ref

wrapper for C<Scalar::Util::weaken>

=item _::ref_unweaken $ref

wrapper for C<Scalar::Util::unweaken>

=item _::ref_is_weak $ref

wrapper for C<Scalar::Util::isweak>

=back

=head2 List::Util and List::MoreUtils

=over 4

=item _::reduce { BLOCK } @list

wrapper for C<List::Util::reduce>

=item _::any { PREDICATE } @list

wrapper for C<List::Util::any>

=item _::all { PREDICATE } @list

wrapper for C<List::Util::all>

=item _::none { PREDICATE } @list

wrapper for C<List::Util::none>

=item _::first { PREDICATE } @list

wrapper for C<List::MoreUtils::first_value>

=item _::first_index { PREDICATE } @list

wrapper for C<List::MoreUtils::first_index>

=item _::last { PREDICATE } @list

wrapper for C<List::MoreUtils::last_value>

=item _::last_index { PREDICATE } @list

wrapper for C<List::MoreUtils::last_index>

=item _::max     @list

=item _::max_str @list

wrappers for C<List::Util::max> and C<List::Util::maxstr>, respectively.

=item _::min     @list

=item _::min_str @list

wrappers for C<List::Util::min> and C<List::Util::minstr>, respectively.

=item _::sum 0, @list

wrapper for C<List::Util::sum>

=item _::product @list

wrapper for C<List::Util::product>

=item _::pairgrep { PREDICATE } @kvlist

wrapper for C<List::Util::pairgrep>

=item _::pairfirst { PREDICATE } @kvlist

wrapper for C<List::Util::pairfirst>

=item _::pairmap { BLOCK } @kvlist

wrapper for C<List::Util::pairmap>

=item _::shuffle @list

wrapper for C<List::Util::shuffle>

=item _::natatime $size, @list

wrapper for C<List::MoreUtils::natatime>

=item _::zip @list1, @list2, ...

wrapper for C<List::MoreUtils::zip>

=item _::uniq @list

wrapper for C<List::MoreUtils::uniq>

=item _::part { INDEX_FUNCTION } @list

wrapper for C<List::MoreUtils::part>

=back

=head2 Carp

=over 4

=item _::carp "Message"

wrapper for C<Carp::carp>

=item _::cluck "Message"

wrapper for C<Carp::cluck>

=item _::croak "Message"

wrapper for C<Carp::croak>

=item _::confess "Message"

wrapper for C<Carp::confess>

=back

=head2 UNIVERSAL

...and other goodies from C<Safe::Isa>

=over 4

=item _::isa $object, 'Class'

wrapper for C<$Safe::Isa::_isa>

=item _::can $object, 'method'

wrapper for C<$Safe::Isa::_can>

=item _::does $object, 'Role'

wrapper for C<$Safe::Isa::_DOES>

=item $maybe_object->_::safecall(method => @args)

wrapper for C<$Safe::Isa::_call_if_object>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/latk/Underscore/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Lukas Atkinson <amon@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Lukas Atkinson.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
