# OOP Architecture

## Classes

## Objects
Objects have two interfaces. The interface you work with after instantiation and the 'self' interface.

'self' holds all data that's defined by instance members (local data).
it references pre-defined members, but does not copy them (saves memory).
with child classes, a large table of references is created, but no data is copied.