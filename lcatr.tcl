# Interface an LCATR software installation to the LCATR job harness

# This file should be sourced by an installations modulefile 

# Register an LCATR modulefile to produce standard environment.  Call
# with the path to the producer and validator programs relative to the
# package's installation area
proc lcatr_package { producer validator } {

    set pkgname "$::env(LCATR_JOB)/$::env(LCATR_VERSION)"
    set pkgpath "$::env(LCATR_INSTALL_AREA)/$pkgname"

    append-path LCATR_LCATR_PKGS "$pkgname"

    setenv LCATR_PRODUCER "$pkgpath/$producer"
    setenv LCATR_VALIDATOR "$pkgpath/$validator"
}
