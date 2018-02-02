# aloopi
**Another Lua OOP Implementation.**

aloopi provides a clean and effective solution to OOP in Lua that includes:

+ **Classes**
    + Inheritance
    + Static members
    + Public and private access
    + Custom meta
	    + With the exception of `__index, __newindex, __metatable`
    + Static typing for variables and functions
	    + Supports multidimensional arrays
            + `f([,]num)` -> two-dimensional array of infinite numbers
        + Supports custom class types
	        + `f(Apple)` -> Apple class
        + Supports dictionaries
            + `table<str, num>` -> dictionary with string keys and number values
        + Supports optionals
	        + `a: num?` ---> a variable that can be `nil` or a `number`.

## Classes
**Member access**

`lowercase` for instance members.
+ Instance members can access instance members (and static by referencing the actual class not self).

`Uppercase` for static members.
+ Static members can only access other static members.

`const` before variable names to define a constant.
+ example: `const FAVORITE_NUM`

 `_` prefix for private members.
 `__` prefix for meta members.
 
 **Defining a class**
 ```lua
 local Fruit = aloopi.class() {
	 -- All classes must define '__type'
	 __type = 'Fruit';
	 
	 --  For objects to be instantiated, a class must define `__init()` as well.
	 ['__init(str, num)'] = function(self, name, yumminess)
	 end;
}

-- Instantiation by calling the class.
local apple = Fruit('Apple', 10)
 ```

## API
This module returns:
        
```lua
BaseClass   class(BaseClass super_class) -> (table members)
```
```lua
string      typeof(any object)
```
+ retrieves `__type` from given class or `type(object)`/`typeof(object)`

```lua
bool        instanceof(Object object, BaseClass parent)
```
+ returns `true` if object is an instance of parent

## Type Declarations    
```lua
['const FAVORITE_NUM'] = 5
```
+ constants cannot be statically typed because they cannot change to begin with.
+ you can define functions as const
	+ `const f(num)`

```lua
['name: str'] = ''
```
+ `name` is the name of the variable.
+ `:` operator is used to denote type.
+ `str` is shorthand for the datatype `string`.

```lua
['f(str, num)'] = function(name, age)
```
+ `f` is the name of the function.
+ parenthesis are required to identify function.
+ `str` is shorthand for `string`.
+ `num` is shorthand for `number`.  

```lua
['f(str, any, num)'] = function(name, something, age)`
```
+ you can omit `any` as in the shorthand version: 
	+ `f(str,, num)`.

### Shorthand Datatype Names
+ `str = string`
+ `num = number`
+ `fn = function`
+ `tab = table`
+ `bool = boolean`
+ `usd = userdata`
+ `thr = thread`
+ `any = any`
	+ Not a datatype but who cares?

### Arrays
Arrays have three main qualities:
+ Datatype
+ Size*
+ Number of dimensions*

#### Arrays can be defined in *two* ways. 
The *preferred* method of defining an array is of the form:
 ```lua
'[' [size ','...] ']' datatype
```
you can define all three of these qualities.

#### Examples:
+ `f([]str)` ---> array of infinite string
+ `f([5]num)` ---> array of five numbers
+ `f([,]num)` ---> two-dimensional array of infinite numbers

##### *There is no limit on size or number of dimensions.

The other way of defining an array is of the form:
```lua
'table<' datatype '>'
```
This defines a one dimensional array of infinite `datatype`.

### Dictionaries
Dictionaries are defined as:
```lua
'table<' key_datatype ',' value_datatype '>'
```
Example:
+ `dict: tab<str, num>` ---> keys: `string`, values: `numbers`

### Variable Arguments*
Define variable arguments in function declarations with:
```lua
datatype '...'
```
##### *Can only be used in function declarations.
##### *No more parameters can be defined after defining variable arguments.
Examples:
+ `f(str...)` ---> variable arguments of type string
+ `f(num, []bool...)` ---> number, infinite arrays of infinite bools

### Optionals
Define a variable or parameter to be optional with `?`.
```lua
['random(num, num?)'] = function(arg1, maybe_a_number_maybe_nil)

['favorite_word: str?'] = nil
```
## Complete Syntax
```lua
statement			=	const_declaration | key_declaration

const_declaration   =   'const' key_declaration

key_declaration     =   var_declaration | fn_declaration  

var_declaration     =   identifier ':' type_expression
fn_declaration      =   identifier '(' fn_type_expression... ')'

fn_type_expression  =   type_expression ['...']
type_expression     =   array_expression | table_expression | datatype

array_expression    =   '[' [NUMBER ',']... ']' datatype
table_expression    =   'table<' type_expression [',' type_expression] '>'
datatype            =   identifier ['?']
  ```