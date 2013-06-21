# CakePHPのModelをDBなしで使う方法

DB使わないけどvalidationだけしたい場合を経験したので共有します。

最初は`$useTable = false;`だけで行けるかと思ったのですが、何かというと
DBにアクセスしたがって少し苦労しました。

たぶんDBなしで動かすこと自体あまり想定されていないと思うので、注意して
やってください。

CakePHP 2.3.6時点の情報です。

## テーブルとの連携を外す

まずはこれを。

```PHP
    public $useTable = false;
```

参考：
- [http://book.cakephp.org/2.0/ja/models/model-attributes.html#usetable](http://book.cakephp.org/2.0/ja/models/model-attributes.html#usetable)
- [http://api.cakephp.org/2.3/class-Model.html#$useTable](http://api.cakephp.org/2.3/class-Model.html#$useTable)

## テーブル定義を自分で設定する

上記をやってもテーブル定義情報がないと内部でDBにアクセスしに行こうとす
るので、自分で設定します。

```PHP
    protected $_schema = array(
        'name'  =>array('type'=>'text'),
        //...
    );
```

typeにどういう値が書けるかなどは、すみません調べてません。
`'text'`と`'integer'`は可能でした。

参考？：
- http://api.cakephp.org/2.3/class-Model.html#$_schema

## データの設定

コントローラからモデルにデータを設定する際に、set()やcreate()を使うと
DBアクセスが発生してしまうので、$dataに直接設定します。

```PHP
    $this->Model->data = $this->request->data;
```

参考：
- http://book.cakephp.org/2.0/en/models/model-attributes.html#data
- http://api.cakephp.org/2.3/class-Model.html#$data

## まとめ

これで`$this->Model->validates()`しても大丈夫なはずです。
