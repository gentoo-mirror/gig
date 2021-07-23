# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="DBus protocol binding for libvirt native C API"
HOMEPAGE="http://libvirt.org"
SRC_URI="https://github.com/libvirt/libvirt-dbus/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/dbus
	sys-auth/polkit
	acct-user/libvirtdbus
"
BDEPEND="
	>=dev-libs/glib-2.44.0
	>=app-emulation/libvirt-3.0.0
	>=app-emulation/libvirt-glib-0.0.7
"
