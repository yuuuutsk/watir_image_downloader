# Rubyによる画像ダウンローダ

### Requirements
- Ruby 2.3.1
- Google Chrome


### 環境構築
以下のwatirのコマンドで最新版watirのweb-driverをインストールする。

```
gem install watir
```

###　ダウンロード
以下のコマンドで、指定したキーワードを元に、google画像検索結果上位100件をダウンロードする。

```
ruby download_image.rb "猫 犬" 100
```