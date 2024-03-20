# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="THE MALI USERSPACE DRIVER (Mali DRIVER)"
HOMEPAGE="https://github.com/JeffyCN/mirrors/tree/libmali"
EGIT_REPO_URI="https://github.com/JeffyCN/mirrors.git"
EGIT_BRANCH="libmali"
EGIT_COMMIT="ab3d91e3df2ef1c487c2d8f69daea1729668e428"

LICENSE="non-free"
SLOT="0"
KEYWORDS="~arm64"
IUSE="X wayland +valhall-g610 utgard-450 midgard-t86x bifrost-g52 bifrost-g31 g6p0 +g13p0 r7p0 r18p0 g2p0 g13p0 g2p0"

DEPEND="
	x11-libs/libdrm
	X? (
		x11-libs/libxcb
		x11-libs/libXdamage
		x11-libs/libXext
	)
	wayland? (
		dev-libs/wayland
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_use valhall-g610 gpu=valhall-g610)
		$(meson_use utgard-450 gpu=utgard-450)
		$(meson_use midgard-t86x gpu=midgard-t86x)
		$(meson_use bifrost-g52 gpu=bifrost-g52)
		$(meson_use bifrost-g31 gpu=bifrost-g31)
		$(meson_use g6p0 version=g6p0)
		$(meson_use g13p0 version=g13p0)
		$(meson_use r7p0 version=r7p0)
		$(meson_use r18p0 version=r18p0)
		$(meson_use g2p0 version=g2p0)
		$(meson_use g13p0 version=g13p0)
		$(meson_use g2p0 version=g2p0)
)
	meson_src_configure
}
