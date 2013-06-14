define ['Human'], (Human) ->
  class User extends Human
    constructor: (@id, @name, @age) ->

  return User
  
