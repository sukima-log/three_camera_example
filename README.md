# MyThree


# 概要
- Three.jsのためのテンプレート
- npm installでライブラリのインストール
    - node_modulesが作成される
- マウスによるカメラの操作2パターンの例

# 説明
- 使用するライブラリ
    - package.json内を確認
- 主要なライブラリ
    - typescript
    - webpack
    - babel
    - three
- 編集するコード
    - src内のコードを編集する
- コマンド
    - package.json内"scripts"を確認
    - 「npm run webpack-build」でdist以下に配布用コード作成
        - webpack --config webpack.config.js
        - webpack.configでapp.txとapp2.tsをどちらを対象とするか使い分ける

# 環境設定
- environment/environment.sh
    - 環境構築可能
    - npmやnode環境を整える（バージョン固定）
- environment/clean.sh
    - webpackで生成されたファイルを削除する（編集推奨）

# 構成
<pre>.
├── babel.config.js
├── dist                // srcからbuildした表示用ファイルをまとめる
│   ├── assets
│   ├── images
│   ├── script
│   └── stylesheets
├── environment
│   ├── clean.sh        // dist内のファイルを削除するスクリプト
│   └── environment.sh  // 環境構築用スクリプト
├── package.json
├── package-lock.json
├── src                 // 開発用フォルダ
│   ├── assets          // 3Dモデルなど
│   ├── images          // 画像など
│   ├── index.html      // top htmlのテンプレート
│   ├── script          // javascript,typescritpなど
│   └── stylesheets     // cssなど
├── tsconfig.json
└── webpack.config.js</pre>

# 補足
- https://github.com/topics/threejs-example
- https://threejs.org/