#!/usr/bin/env python3

''' LICENSE HEADER
  The MIT License (MIT)

  Copyright © 2026 Jordan Irwin (AntumDeluge)

    See: LICENSE.txt
'''


import errno
import os
import sys
from datetime import date


def getVersion():
	return str(date.today()).replace("-", ".")


def getContents(package, version):
	# WIP:
	lines = [
		f"package = \"{package}\"",
		f"version = \"{version}\"",
		"\nsource = {",
		f"\turl = \"git://codeberg.org/AntumDeluge/{package}.git\",",
		f"\ttag = \"{version}\"",
		"}",
		"\ndescription = {",
		"}",
		"\ndependencies = {",
		"}",
		"\nbuild = {",
		"}"
	]

	return "\n".join(lines)


def writeRockspec():
	if "root" not in globals():
		sys.stderr.write("\nERROR: invalid invocation, cannot determine root directory\n")
		sys.exit(1)

	version = getVersion()
	contents = getContents("lua-class", version)
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
