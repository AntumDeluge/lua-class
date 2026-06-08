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


ClassE = NewClass()


local a = ClassA("foo")
local b = ClassB("bar")
local e = ClassE()

print("\nobject a:")
print("  type:             "..type(a))
print("  tostring:         "..tostring(a))
print("  class UUID:       "..a:getClassUUID())
print("  a:getClassName(): "..a:getClassName())
print("  a:getName():      "..a:getName())
print("  instanceof:")
print("    Class:          "..tostring(a:instanceof(Class)))
print("    ClassA:         "..tostring(a:instanceof(ClassA)))
print("    ClassB:         "..tostring(a:instanceof(ClassB)))
print("    ClassE:         "..tostring(a:instanceof(ClassE)))

print("\nobject b:")
print("  type:             "..type(b))
print("  tostring:         "..tostring(b))
print("  class UUID:       "..b:getClassUUID())
print("  b:getClassName(): "..b:getClassName())
print("  b:getName():      "..b:getName())
print("  instanceof:")
print("    Class:          "..tostring(b:instanceof(Class)))
print("    ClassA:         "..tostring(b:instanceof(ClassA)))
print("    ClassB:         "..tostring(b:instanceof(ClassB)))
print("    ClassE:         "..tostring(b:instanceof(ClassE)))

print("\nobject e:")
print("  type:             "..type(e))
print("  tostring:         "..tostring(e))
print("  class UUID:       "..e:getClassUUID())
print("  instanceof:")
print("    Class:          "..tostring(e:instanceof(Class)))
print("    ClassA:         "..tostring(e:instanceof(ClassA)))
print("    ClassB:         "..tostring(e:instanceof(ClassB)))
print("    ClassE:         "..tostring(e:instanceof(ClassE)))
