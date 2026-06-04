#!/usr/bin/env python3

''' LICENSE HEADER
  The MIT License (MIT)

  Copyright © 2026 Jordan Irwin (AntumDeluge)

    See: LICENSE.txt
'''


import errno
import os
import sys
from datetime import datetime


def getVersion():
	tag = datetime.now().strftime("%Y-%m-%d")
	return tag.replace("-", ".")+"-1", tag


def getContents(package, version, tag):
	lines = [
		f'package = "{package}"',
		f'version = "{version}"',
		'\nsource = {',
		f'\turl = "git://codeberg.org/AntumDeluge/{package}.git",',
		f'\ttag = "{tag}"',
		'}',
		'\ndescription = {',
		'\tsummary = "Lua library that provides method for creating class-like tables that can be instantiated.",',
		'\tdetailed = [[]],',
		'\tlicense = "MIT",',
		'\thomepage = "https://codeberg.org/AntumDeluge/lua-class",',
		'\tmaintainer = "antumdeluge@gmail.com"',
		'}',
		'\ndependencies = {',
		'}',
		'\nbuild = {',
		'\ttype = "builtin",',
		'\tmodules = {',
		'\t\t["lua-class.init"] = "lua-class.lua"',
		'\t}',
		'}\n'
	]

	return "\n".join(lines)


def writeRockspec():
	if "root" not in globals():
		sys.stderr.write("\nERROR: invalid invocation, cannot determine root directory\n")
		sys.exit(1)

	version, tag = getVersion()
	contents = getContents("lua-class", version, tag)
	rockspec = os.path.join(root, f"lua-class-{version}.rockspec")

	if os.path.exists(rockspec):
		if os.path.isdir(rockspec):
			sys.stderr.write(f"\nERROR: cannot write rockspec file, directory exists: {rockspec}")
			sys.exit(errno.EISDIR)
		elif os.path.isfile(rockspec):
			os.remove(rockspec)

	# TODO: error handling
	fout = open(rockspec, "w")
	fout.write(contents)
	fout.close()

	if os.path.isfile(rockspec):
		print(f"\nrockspec file created: {rockspec}")


if __name__ == "__main__":
	root = os.path.dirname(__file__)
	os.chdir(root)

	writeRockspec()
