
# Lua Classes (OOP)

## Description

Lua library that provides method for creating class-like tables that can be instantiated.

## Notes

Code is AI assisted. AI was used for reference &amp; code checking.

## Usage

A single function, `NewClass`, is provided &amp; can be called with the following parameters:

- `NewClass()`: Creates a bare-minimum new class without inheritence.
- `NewClass(template)`: Creates a new class from `template` without inheritence. Same as
  `NewClass(nil, template)`.
- `NewClass(parent, template)`: Creates a new class from `template` with inheritence from `parent`.

Parameter descriptions:

- `template`: Table template of new class.
- `parent`: The parent class that is being inherited.

Construction calls the `template.__init` function property. If the template table does not have the
function, a default with only the `self` parameter will be added.

```
-- example of creating a class with a custom constructor
local MyClass = NewClass({
  __init = function(self, name)
    self.name = name
  end
})
```

See [example](example.lua).

## Licensing

- [MIT](LICENSE.txt)

## Links

Git Repo Mirrors:
- [Codeberg](https://codeberg.org/AntumDeluge/lua-class)
- [GitHub](https://github.com/AntumDeluge/lua-class)
- [GitLab](https://gitlab.com/AntumDeluge/lua-class)

## TODO

- Option to make function properties private.
- Mixin support.
- Support calling super-class functions.
- Support checking inheritence with `instanceof` like function.
