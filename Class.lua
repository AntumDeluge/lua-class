
--[[ LICENSE HEADER
  The MIT License (MIT)

  Copyright © 2026 Jordan Irwin (AntumDeluge)

    See: LICENSE.txt
--]]


--- Construction helper table.
--
--  This table serves as a template for creating a constructor for classes to be instantiated. The
--  class must have a constructor function named "__init" which is called during instantiation.
local ClassMeta = {
	--- Meta constructor.
	--
	--  Called during instantiation to create a new object.
	--
	--  @param class
	--    Meta table class.
	--  @param ...
	--    All parameters that should be passed to the class constructor.
	__call = function(class, ...)
		local instance = setmetatable({}, class)
		class.__init(instance, ...)
		return instance
	end,

	__tostring = function(self)
		return "foobar"
	end
}
