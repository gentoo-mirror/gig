# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils pam systemd git-r3

DESCRIPTION="Server Administration Web Interface "
HOMEPAGE="http://cockpit-project.org/"
EGIT_REPO_URI="https://github.com/cockpit-project/cockpit.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS=""
IUSE="debug doc firewalld +networkmanager pcp selinux udisks tuned"

BDEPEND="
	>=app-crypt/mit-krb5-1.11
	>=dev-libs/glib-2.50
	>=dev-libs/json-glib-1.4
	>=net-libs/gnutls-3.6.0
	>=net-libs/libssh-0.8.5[server]
	>=sys-apps/systemd-235[policykit]
	>=sys-auth/polkit-0.105[systemd]
	doc? (
		app-text/xmlto
	)
"
DEPEND="
	dev-libs/libpwquality
	dev-python/dbus-python
	net-libs/nodejs[npm]
	networkmanager? (
		firewalld? (
			net-firewall/firewalld
		)
		net-misc/networkmanager[policykit,systemd]
	)
	pcp? (
		app-metrics/pcp
	)
	sys-apps/accountsservice[systemd]
	udisks? (
		sys-fs/udisks[lvm,systemd]
	)
	tuned? (
		sys-apps/tuned
	)
	virtual/libcrypt:=
"

RDEPEND="${DEPEND}
	acct-group/cockpit-ws
	acct-group/cockpit-wsinstance
	acct-user/cockpit-ws
	acct-user/cockpit-wsinstance
	dev-libs/libgudev
	net-libs/glib-networking[ssl]
	virtual/krb5
"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable pcp)
		$(use_enable doc)
		"--with-pamdir=/lib64/security"
		"--with-cockpit-user=cockpit-ws"
		"--with-cockpit-ws-instance-user=cockpit-wsinstance"
		"--with-cockpit-group=cockpit-ws"
		"--localstatedir=/var")
	econf "${myconf[@]}"
}

src_install(){
	emake DESTDIR="${D}" install || die "emake install failed"

	if ! use selinux ; then
		rm -rf "${D}"/usr/share/cockpit/selinux
		rm -rf "${D}"/usr/share/metainfo/org.cockpit-project.cockpit-selinux.metainfo.xml
	fi

	rm -rf "${D}"/usr/share/cockpit/{packagekit,playground,sosreport}
	rm -rf "${D}"/usr/share/metainfo/org.cockpit-project.cockpit-sosreport.metainfo.xml

	ewarn "Installing experimental pam configuration file"
	ewarn "use at your own risk"
	newpamd "${FILESDIR}/cockpit.pam" cockpit
	dodoc README.md AUTHORS
}

pkg_postinst() {
	elog ""
	elog "To enable Cockpit run:"
	elog " - systemctl enable --now cockpit.socket"
	elog ""
}
