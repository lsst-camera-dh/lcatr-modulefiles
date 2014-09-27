#!/usr/bin/env python
import sys
import argparse
import os
import os.path
import shutil
import glob
from collections import defaultdict

# packages should be installed under 
#  <root>/lib/pythonMAJ.MIN/site-packages
# where MAJ = sys.version_info.major and MIN = sys.version_info.minor
# But modulefiles has no python to install!

parser = argparse.ArgumentParser(description='install lcatr/modulefiles')
parser.add_argument('jhRoot', action='store', metavar='root',
                    help='Root of job harness installation')
parser.add_argument('--update', '-u', action='store_true', dest = 'update',
                    default=False,
                    help='allow overwrite of existing installation')
args = parser.parse_args()

jhRoot = vars(args)['jhRoot']
update = vars(args)['update']
pkg = 'lcatr/modulefiles'

pythonversion = 'python' + str(sys.version_info.major) + '.' + str(sys.version_info.minor)
sitePkgs = os.path.join(jhRoot, 'lib', pythonversion, 'site-packages')
if (not os.path.isdir(sitePkgs)) or (not os.path.isdir(os.path.join(jhRoot, 'bin'))):
    print root + ' is not root of a job harness installation'
    exit

pkgtop = os.path.dirname(sys.argv[0])


if os.path.isfile(os.path.join(jhRoot, 'bin', 'lcatr-modulefiles-config')):
    if not update:
        print 'Some version of the package is already installed'
        print 'Delete or move away before attempting new install'
        print 'or re-invoke with --update option'
        exit
    else:
        print 'Overwriting old version'



shutil.copy(os.path.join(pkgtop, 'bin/lcatr-modulefiles-config'), 
            os.path.join(jhRoot, 'bin'))

os.chdir(pkgtop)
files = defaultdict(list)
for path in glob.glob('modules/*/*'):
    if path[-1] == '~':
        continue
    _,k,v = path.split('/')
    files['share/modulefiles/'+k].append(path)

files['share/modulefiles'] = glob.glob('lib/*.tcl')

for key in files:
    #print 'value for key ' + key + ' is:'
    #print files[key]
    if not os.path.isdir(os.path.join(jhRoot, key)):
        os.makedirs(os.path.join(jhRoot, key))
    for f in files[key]:
        shutil.copy(f, os.path.join(jhRoot, key))
 






