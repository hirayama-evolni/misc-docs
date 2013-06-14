require ['Recipe', 'Author', 'User', 'Review', 'Ingredient'], (Recipe, Author, User, Review, Ingredient) ->
  r = new Recipe()
  
  author = new Author "pen_name", "foo", "anonymouns", 20
  review_user = new User "bar", "anonymouns2", 30
  review = new Review review_user,"Yummy!"
  ingredient = new Ingredient "cucumber"

  recipe = new Recipe()
  recipe.author = author
  recipe.addReview review
  recipe.addIngredient ingredient

  console.log recipe

  return  

  
