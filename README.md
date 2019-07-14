# php_web_container_alpine

# Overview

Alpine Linux, Apache, PHP 7.3, Composer を実装するコンテナ環境を構築

# Description

```
php_container
├ config
│ ├ ca                // SSL証明書（オレオレ）
│ │ ├ server.crt
│ │ └ server.csr
│ ├ httpd.conf        // Apache設定ファイル
│ ├ php.ini           // php設定ファイル
│ └ virtual-host.conf // VirtualHost設定
├ src                 // PHPソース置き場
└ Dockerfile
```

# Usaga

```
＃ コンテナビルド
docker build -t php_container_alpine:latest .

＃ コンテナ起動
docker run --name php_container_alpine -d -p 80:80 -p 443:443 php_container_alpine:latest
```

hosts 設定

```
127.0.0.1 nishimu.com
```

ブラウザで `http://nisimu.com` の表示を確認

※ドメイン名は、virtual-host.conf にで適宜設定
