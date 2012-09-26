# utilities for use by modulefiles

#puts "util.tcl loading"

# return the Git SHA1 hash of the current commit of the given directory
proc git_hash { dir } {
    set save_cwd [pwd]
    cd $dir
    set ret [exec git rev-parse HEAD]
    cd $save_cwd
    return $ret
}

#puts [info globals]
#puts [file dirname [info script]]
#puts [git_hash /home/bviren/work/lsst/lcatr/modulefiles]


# Set the outdir - (less the final job ID!)
proc set_outdir { dep } {

    global env

    set depnamever [split "$dep" "/"]
    set depname [lrange $depnamever end-1 end-1]
    set depver  [lrange $depnamever end   end]
    
    set outdir [file join $env(CCDTEST_ROOT) $env(CCDTEST_CCD_ID) $depname $depver]
    set updepname [string toupper $depname]

    setenv CCDTEST_${updepname}_OUTDIR $outdir
    return $outdir
}

proc lcatr_package { hash args } {

    # must do deps first
    foreach dep $args {
	append-path CCDTEST_DEPS "$dep"
	#set_outdir $dep
	module load $dep
    }

    global ModulesCurrentModulefile
    set path [split "$ModulesCurrentModulefile" "/"]
    set name [lrange $path end-1 end-1]
    set ver  [lrange $path end   end]

    #set od [set_outdir "$name/$ver"]
    #setenv CCDTEST_OUTDIR $od/$env(CCDTEST_

    setenv CCDTEST_NAME $name
    setenv CCDTEST_VERSION $ver
    setenv CCDTEST_GIT_HASH $hash

    setenv CCDTEST_MODULEFILES_HASH [git_hash [file dirname [info script]]]

    set helpstring [format "%s/%s - set up environment for %s version %s" $name $ver $name $ver]
    module-whatis $helpstring
}

lcatr_package deadbeaf02deadbeaf02deadbeaf02deadbeaf02
# lcatr_package name2 name1
# lcatr_package name3 name2 name1

# Determine the site
proc site { foo } {
    puts [info hostname]
    puts $foo
}

# site bar

