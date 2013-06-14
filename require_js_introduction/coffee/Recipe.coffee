define ->
  class Recipe
    constructor: ->
      @reviews = []
      @author = null
      @ingredients = []

    addReview: (r) ->
      @reviews.push r
  
    addIngredient: (i) ->
      @ingredients.push i

  return Recipe
