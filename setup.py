#!/usr/bin/env python
from glob import glob
from distutils.core import setup
from collections import defaultdict

files = defaultdict(list)
for path in glob('modules/*/*'):
    if path[-1] == '~':
        continue
    _,k,v = path.split('/')
    files['share/modulefiles/'+k].append(path)
files['share/modulefiles'] = glob('lib/*.tcl')
print files.items()
setup(name='lcatr-modulefiles',
      version='0.2',
      url='https://git.racf.bnl.gov/astro/cgit/lcatr/modules.git',
      author='Brett Viren',
      author_email='bv@bnl.gov',
      #package_dir = {'': 'python'},
      #packages = ['lcatr','lcatr.harness'],
      scripts = [ 'bin/lcatr-modulefiles-config' ],
      data_files = files.items(),
      )
