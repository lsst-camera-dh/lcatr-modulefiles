# utilities for use by modulefiles

puts "util.tcl loading"

# return the Git SHA1 hash of the current commit of the given directory
proc git_hash { dir } {
    set save_cwd [pwd]
    cd $dir
    

    cd $save_cwd
}

proc lcatr_package { args } {

    # must do deps first
    foreach dep $args {
	append-path CCDTEST_DEPS $dep
	module load $dep
    }

    global ModulesCurrentModulefile
    set path [split "$ModulesCurrentModulefile" "/"]
    set name [lrange $path end-1 end-1]
    set ver  [lrange $path end   end]

    setenv CCDTEST_NAME $name
    setenv CCDTEST_VERSION $ver

    set helpstring [format "%s/%s - set up environment for %s version %s" $name $ver $name $ver]
    module-whatis $helpstring
}

# lcatr_package name1 
# lcatr_package name2 name1
# lcatr_package name3 name2 name1

# Determine the site
proc site { foo } {
    puts [info hostname]
    puts $foo
}

# site bar

