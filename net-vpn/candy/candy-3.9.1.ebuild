# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Another virtual private network that supports peer-to-peer connections"
HOMEPAGE="https://github.com/lanthora/candy"
SRC_URI="https://github.com/lanthora/candy/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~*"

DEPEND="
	dev-libs/spdlog
	dev-libs/uriparser
	dev-libs/libconfig
	net-libs/ixwebsocket[ws]
	dev-libs/openssl
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply "${FILESDIR}/${P}-use-system-ixwebsocket.patch"
	cmake_src_prepare
	default
}
