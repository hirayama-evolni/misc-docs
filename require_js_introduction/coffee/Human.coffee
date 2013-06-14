define ['Animal'], (Animal) ->
  class Human extends Animal
    constructor: (@name, @age) ->

  return Human
