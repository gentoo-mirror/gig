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
IUSE="X wayland"

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
