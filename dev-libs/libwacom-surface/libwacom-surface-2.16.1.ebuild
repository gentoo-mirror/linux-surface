# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit meson python-any-r1 udev

DESCRIPTION="libwacom with patches to support Microsoft Surface Devices"
HOMEPAGE="https://github.com/linux-surface/libwacom-surface"
SRC_URI="https://github.com/linuxwacom/libwacom/releases/download/libwacom-${PV}/libwacom-${PV}.tar.xz"
S="${WORKDIR}/libwacom-${PV}"

LICENSE="MIT"
SLOT="0/9" # libwacom SONAME
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libevdev
	dev-libs/libgudev:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	test? (
		$(python_gen_any_dep '
			dev-python/libevdev[${PYTHON_USEDEP}]
			dev-python/pyudev[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		')
	)
"

python_check_deps() {
	use test || return 0
	python_has_version \
		"dev-python/libevdev[${PYTHON_USEDEP}]" \
		"dev-python/pyudev[${PYTHON_USEDEP}]" \
		"dev-python/pytest[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	eapply "${FILESDIR}/2.16.1/0001-Add-support-for-BUS_VIRTUAL.patch"
	eapply "${FILESDIR}/2.16.1/0002-Add-support-for-Intel-Management-Engine-bus.patch"
	eapply "${FILESDIR}/2.16.1/0003-data-Add-Microsoft-Surface-Pro-3.patch"
	eapply "${FILESDIR}/2.16.1/0004-data-Add-Microsoft-Surface-Pro-4.patch"
	eapply "${FILESDIR}/2.16.1/0005-data-Add-Microsoft-Surface-Pro-5.patch"
	eapply "${FILESDIR}/2.16.1/0006-data-Add-Microsoft-Surface-Pro-6.patch"
	eapply "${FILESDIR}/2.16.1/0007-data-Add-Microsoft-Surface-Pro-7.patch"
	eapply "${FILESDIR}/2.16.1/0008-data-Add-Microsoft-Surface-Pro-7.patch"
	eapply "${FILESDIR}/2.16.1/0009-data-Add-Microsoft-Surface-Pro-8.patch"
	eapply "${FILESDIR}/2.16.1/0010-data-Add-Microsoft-Surface-Pro-9.patch"
	eapply "${FILESDIR}/2.16.1/0011-data-Add-Microsoft-Surface-Book.patch"
	eapply "${FILESDIR}/2.16.1/0012-data-Add-Microsoft-Surface-Book-2-13.5.patch"
	eapply "${FILESDIR}/2.16.1/0013-data-Add-Microsoft-Surface-Book-2-15.patch"
	eapply "${FILESDIR}/2.16.1/0014-data-Add-Microsoft-Surface-Book-3-13.5.patch"
	eapply "${FILESDIR}/2.16.1/0015-data-Add-Microsoft-Surface-Book-3-15.patch"
	eapply "${FILESDIR}/2.16.1/0016-data-Add-Microsoft-Surface-Laptop-Studio.patch"
	eapply_user

	# Don't call systemd daemon-reload in the test suite
	sed -i -e '/daemon-reload/d' test/test_udev_rules.py || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature doc documentation)
		$(meson_feature test tests)
		-Dudev-dir=$(get_udevdir)
	)
	meson_src_configure
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
