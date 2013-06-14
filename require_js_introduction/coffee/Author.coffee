define ['User'], (User) ->
  class Author extends User
    constructor: (@pen_name, @id, @name, @age) ->

  return Author
