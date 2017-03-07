# Rubyによる画像ダウンローダ

### Requirements
- Ruby 2.3.1
- Google Chrome


### 環境構築
watirのgemをインストールする。

```
gem install watir
```

Google chromeのweb-driverをインストールする。

```
brew install chromedriver
```

### 保存用ディレクトリを作成
```
mkdir downloads
```

### 画像ダウンロード
以下のコマンドで、指定したキーワードを元に、google画像検索結果上位100件をダウンロードする。(jpeg画像のみダウンロードするように修正)

```
ruby download_image.rb "歩行者 単体" 100
```