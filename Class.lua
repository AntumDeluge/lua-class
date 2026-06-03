
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


--- Function called to create a new class table.
--
--  After creation, class can then be instantiated with `ClassName([<args>])`. Can be called with
--  the following argument options.
--
--  - NewClass(): Creates a bare-minimum new class without inheritence.
--  - NewClass(template): Creates a new class from `template` without inheritence.
--  - NewClass(parent, template): Creates a new class from `template` with inheritence from
--    `parent`. Same as `NewClass(nil, template)`.
--
--  @param parent
--    The parent class that is being inherited.
--  @param template
--    Table template of new class.
NewClass = function(parent, template)
	-- allow calling with class template table as single argument
	if template == nil then
		template = parent
		parent = nil
	end

	local class = template or {}
	class.__index = class

	if parent ~= nil then
		-- preserves inheritence
		setmetatable(class, {__index = parent, __call = ClassMeta.__call})
	else
		setmetatable(class, ClassMeta)
	end

	if class.__init == nil then
		-- default constructor (must be added after `setmetatable`)
		class.__init = function(self) end
	end

	return class
end
