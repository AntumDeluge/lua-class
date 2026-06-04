#!/usr/bin/env lua


-- use script directory if not installed as Lua rock
local root = arg[0]:match("(.*[/\\])"):gsub("/*$", "") or "."
package.path = package.path..";"..root.."/?.lua"

require("lua-class")


ClassA = NewClass({
	__init = function(self, name)
		self.name = name
	end,

	getClassName = function(self)
		return "ClassA"
	end,

	getName = function(self)
		return self.name
	end
})


ClassB = NewClass(ClassA, {
	-- override super method
	getClassName = function(self)
		return "ClassB"
	end
})


EmptyClass = NewClass()


local a = ClassA("foo")
local b = ClassB("bar")
local e = EmptyClass()

print(a:getClassName().." ("..a:getName()..") ("..type(a)..") ("..tostring(a)..")")
print(b:getClassName().." ("..b:getName()..") ("..type(b)..") ("..tostring(b)..")")
print("Empty class  ("..type(e)..") ("..tostring(e)..")")
