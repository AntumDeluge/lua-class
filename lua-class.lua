
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
	__type = "class",

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
		local mt = getmetatable(instance)
		mt.__type = "class_object"
		mt.__tostring = getmetatable(class).__tostring
		class.__init(instance, ...)
		local parent = class:getParentClass()
		return instance
	end,

	__tostring = function(class)
		return type(class)..": "..string.format("%p", class)
	end
}


local current_uuid = 1000
local nextClassUUID = function(class)
	uuid = current_uuid
	current_uuid = current_uuid + 1
	return uuid
end


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
	-- ensure sub-class of Class
	parent = parent or Class

	local class = {}
	if type(template) == "table" or type(template) == "class" and template ~= parent then
		for k, v in pairs(template) do
			class[k] = v
		end
	end
	class.__index = class

	local cm = {
		__index = parent,
		__uuid = nextClassUUID()
	}
	for k, v in pairs(ClassMeta) do
		cm[k] = v
	end
	setmetatable(class, cm)

	if class.__init == nil then
		-- default constructor (must be added after `setmetatable`)
		class.__init = function(self) end
	end

	return class
end


--- Base class for all new classes to inherit.
Class = NewClass({
	--- Retrieves class's unique identifier.
	--
	--  @return
	--    UUID.
	getClassUUID = function(self)
		mt = getmetatable(self:getClass())
		return mt and mt.__uuid
	end,

	--- Retreives the parent class of this class or instance.
	--
	--  @return
	--    Class that this inherits or `nil`.
	getParentClass = function(self)
		local mt = self and getmetatable(self)
		return mt and mt.__index or nil
	end,

	--- Retrievies class of this instance.
	--
	--  @return
	--    Class implementation.
	getClass = function(self)
		if type(self) == "class" then
			return self
		elseif type(self) == "class_object" then
			return self:getParentClass()
		end
	end,

	--- Checks if this class is an instance of another.
	--
	--  @param other
	--    Class from which to look for inheritence.
	instanceof = function(self, other)
		if type(self) ~= "class_object" or type(other) ~= "class" then
			return false
		end

		local target_uuid = other:getClassUUID()
		local current = self:getClass()
		while current do
			uuid = current:getClassUUID()
			if uuid == target_uuid then
				return true
			end
			current = current:getParentClass()
		end
		return false
	end
})


local super_type = type
--- Wrapper for `type` function to support classes.
--
--  @param obj
--    Object being examined.
type = function(obj)
	local t = super_type(obj)
	if t == "table" then
		local meta_t = getmetatable(obj)
		if meta_t and meta_t.__type then
			t = meta_t.__type
		end
	end
	return t
end
