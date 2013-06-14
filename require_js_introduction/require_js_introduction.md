# RequireJSとは

JavaScriptのモジュールローダーです。

# 何がうれしいのか

DOMを少しいじるだけとかなら平気ですが、BackboneやAngularJSな
どのクライアントサイドアプリで大量のjsファイルがある場合など、それぞれ
のjsファイルがどの(別の)jsファイルに依存しているのか、個々のファイルレ
ベルでは把握できるかもしれませんが、それを`<script>`タグでロードする場
合、全体としてどういう順序でロードすれば依存性を満足できるのか把握する
のが難しくなります。

RequireJSを使うと、依存性を個別のモジュール(ファイル)ごとに定義するこ
とで、自動的に依存性を満足するようにモジュールをロードしてくれます。

また、モジュール化することで、globalの名前空間を汚さずにexportしたいも
のだけ外に見せられるようにもなります。

# サンプル

説明しやすいのでCoffeeScriptのクラスを使っています。

# ディレクトリ構成

```
├── Gruntfile.js
├── coffee
│   ├── Animal.coffee
│   ├── Author.coffee
│   ├── Human.coffee
│   ├── Ingredient.coffee
│   ├── Recipe.coffee
│   ├── Review.coffee
│   ├── User.coffee
│   └── main.coffee
├── index.html
├── js
│   ├── Animal.js
│   ├── Author.js
│   ├── Human.js
│   ├── Ingredient.js
│   ├── Recipe.js
│   ├── Review.js
│   ├── User.js
│   ├── main.js
│   └── require.js
└── package.json

```

## 概要

レシピ登録アプリのために、(無理やり)次のような継承関係のクラスを作ります。

```
Author <- User <- Human <- Animal
```

また、データ構造はこのような感じになります。

```
Recipe -+- Author(0..1)
        |
        +- Ingredients(0..n)
        |
        +- Review(0..n) -+- User
                         |
                         +- text
```

## モジュール定義の基本形式

モジュールは`define`を使用して定義します。

```javascript
define([依存モジュール名１, …], function(...){
  return exports;
});
```

外部に公開するオブジェクトをreturnするようにします。

## モジュールの作成(依存がない場合)

例えばAnimalクラスのように他に依存しているものがない場合、依存モジュー
ルの配列は省略できます。

Animal.coffee:
```coffeescript
define ->
  class Animal
    constructor: (@age) ->

  return Animal
```

ここではAnimalというクラスを作ってそれをreturnしています。

## モジュールの作成(依存がある場合)

HumanクラスはAnimalクラスに依存しています。

依存しているモジュールがある場合は、`define`の最初の引数にモジュール名
の配列を設定します。

次の引数が関数なのは同じですが、この関数の引数として、最初の引数に記述
したそれぞれのモジュールから公開されたオブジェクトが順に渡されます。

Human.coffee:
```coffeescript
define ['Animal'], (Animal) ->
  class Human extends Animal
    constructor: (@name, @age) ->

  return Human
```

ここでは`define`の第一引数でAnimalモジュールに依存することが書かれてい
るので、次の関数の第一引数にはAnimalモジュールから返されたオブジェクト、
すなわちAnimalクラスの定義が渡されます。従ってそれを継承して新たなクラ
スを作成することができます。

## トップレベルのjs

トップレベルのスターティングポイントとしてのjsファイルがひとつ必要にな
ります。

この中では`require`関数を使用します。書式は`define`と同様です。

main.coffee:
```coffeescript
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
```

ここでは`Recipe`、`Author`、`User`、`Review`、`Ingredient`の各モジュー
ルをロードし、ひとつのRecipeオブジェクトと関連データを作成しています。

## scriptタグ

最後にhtmlのscriptタグでrequire.jsをロードします。

```html
<script data-main="js/main" src="js/require.js"></script>
```
data-main属性にトップレベルモジュールを指定します。

## 実行結果

このように目的のオブジェクトが生成されています。

## まとめ

jQueryで少し効果を付けるくらいであれば不要だと思いますが、クライアント
MVCのような中規模以上のアプリ開発においては、このようなモジュールロー
ダーがないとほぼ確実に破綻すると思います。

ぜひ試してみてください。

