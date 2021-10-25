EAPI="8"
ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="15"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
HOMEPAGE="https://github.com/Parinz/linux-surface-overlay/"
IUSE="experimental"

DESCRIPTION="Full sources including the Gentoo patchset and Surface patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"


src_prepare() {
	eapply "${FILESDIR}/5.14/0001-surface3-oemb.patch"
	eapply "${FILESDIR}/5.14/0002-mwifiex.patch"
	eapply "${FILESDIR}/5.14/0003-ath10k.patch"
	eapply "${FILESDIR}/5.14/0004-ipts.patch"
  eapply "${FILESDIR}/5.14/0005-surface-sam.patch"
	eapply "${FILESDIR}/5.14/0006-surface-sam-over-hid.patch"
	eapply "${FILESDIR}/5.14/0007-surface-gpe.patch"
  eapply "${FILESDIR}/5.14/0008-surface-button.patch"
	eapply "${FILESDIR}/5.14/0009-surface-typecover.patch"
	eapply "${FILESDIR}/5.14/0010-cameras.patch"
	eapply "${FILESDIR}/5.14/0011-amd-gpio.patch"
	eapply_user
}


pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the overlay developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""
}


pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
