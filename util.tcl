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
    
    set outdir [file join $env(LCATR_ROOT) $env(LCATR_CCD_ID) $depname $depver]
    set updepname [string toupper $depname]

    setenv LCATR_${updepname}_OUTDIR $outdir
    return $outdir
}

# Register an LCATR modulefile to produce standard environment.  Call
# with the path to the producer and validator programs a git commit
# hash and a list of any dpendencies ("module/version" pairs).
proc lcatr_package { producer validator hash args } {

    #puts "HASH: $hash"
    #puts "ARGS: $args"

    # must do deps first
    foreach dep $args {
	module load $dep
    }

    global ModulesCurrentModulefile
    set path [split "$ModulesCurrentModulefile" "/"]
    set name [lrange $path end-1 end-1]
    set ver  [lrange $path end   end]
    set base [join [lrange $path 0 end-2] "/"]

    #set od [set_outdir "$name/$ver"]
    #setenv LCATR_OUTDIR $od/$env(LCATR_

    append-path LCATR_LCATR_PKGS "$name/$ver"
    setenv LCATR_NAME $name
    setenv LCATR_VERSION $ver
    setenv LCATR_PRODUCER $producer
    setenv LCATR_VALIDATOR $validator
    setenv LCATR_GIT_HASH $hash
    
    setenv LCATR_MODULEFILES_HASH [git_hash $base]

    set helpstring [format "%s/%s - set up environment for %s version %s" $name $ver $name $ver]
    module-whatis $helpstring
}

# lcatr_package deadbeaf02deadbeaf02deadbeaf02deadbeaf02
# lcatr_package name2 name1
# lcatr_package name3 name2 name1

# Determine the site
proc site { foo } {
    puts [info hostname]
    puts $foo
}

# site bar

