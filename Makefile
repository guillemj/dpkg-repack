# Copyright © 2022 Guillem Jover <guillem@debian.org>
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

deb_build_parallel := $(filter parallel=%,$(DEB_BUILD_OPTIONS))
ifdef deb_build_parallel
  DEB_BUILD_OPTION_PARALLEL = $(patsubst parallel=%,%,$(deb_build_parallel))
endif

DEB_VERSION ?= $(shell dpkg-parsechangelog -SVersion)
SOURCE_DATE_EPOCH ?= $(shell dpkg-parsechangelog -STimestamp)
MAN_DATE := $(shell TZ=UTC0 LC_ALL=C date --date='@$(SOURCE_DATE_EPOCH)' '+%F')

INSTALL = install
SED = sed
CHMOD = chmod
POD2MAN = pod2man
PROVE = prove
PROVE_OPTS = $(DEB_BUILD_OPTION_PARALLEL:%=-j%)

all: build

%.1: %.pod
	$(POD2MAN) \
	  --section 1 \
	  --center='dpkg suite' \
	  --date='$(MAN_DATE)' \
	  --release='$(DEB_VERSION)' \
	  $< $@

%: %.pl
	$(SED) \
	  -e "s:my \$$VERSION = .*;:my \$$VERSION = '$(DEB_VERSION)';:" \
	  <$< >$@
	$(CHMOD) +x $@

build: dpkg-repack dpkg-repack.1

install: build
	$(INSTALL) -d $(DESTDIR)/usr/bin
	$(INSTALL) dpkg-repack $(DESTDIR)/usr/bin
	$(INSTALL) -d $(DESTDIR)/usr/share/man/man1
	$(INSTALL) dpkg-repack.1 $(DESTDIR)/usr/share/man/man1

check:
	$(PROVE) $(PROVE_OPTS)

authorcheck:
	AUTHOR_TESTING=1 $(MAKE) check

dist:
	git archive \
	  --prefix=dpkg-repack-$(DEB_VERSION)/ \
	  --output=dpkg-repack-$(DEB_VERSION).tar.xz \
	  $(DEB_VERSION)

clean:
	$(RM) dpkg-repack dpkg-repack.1
