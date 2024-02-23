#bin/sh

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT


#- 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : Next change directory!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

sudo apt-get update && apt-get -y install sudo

#- environmentに移動
cd $CURRENT

pwd

if [ $# -eq 0 ]; then
#- 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : Next npm & node install!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait
# =========================================================
# 参考：
# https://qiita.com/seibe/items/36cef7df85fe2cefa3ea
# =========================================================

#- nodejs & npm
sudo apt install -y nodejs npm
#- n package
sudo npm install n -g

#- node(安定版導入)
# sudo n stable

#- node (バージョン指定)
sudo n 18.16.1

#- 古いnodejs, npm環境設定をすべて削除
sudo apt purge -y nodejs npm
sudo apt autoremove -y

#- 現在のシェルを新しいシェルに入れ替えて以下のelse以降続行
exec $SHELL -l ./environment.sh hoge

else
#- 上記の続き
#- バージョン確認
echo "node.jsのバージョン"
node -v

#- バージョン確認
echo "npm（パッケージマネージャー）のバージョン"
npm -v


#- 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : Next npm Environment Setting!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

# 参考(テンプレファイル):https://liginc.co.jp/560646
# 参考(ファイル解説):https://tyablog.net/2017/03/29/typescript-three-js/

# --------------------------------------------------------
# <npmでプロジェクトを始める>
# npm init			// 対象フォルダに移動してから初期化
# 				// package.jsonが作成される

# <package.jsonにライブラリ（モジュール）を記録>
# npm install ライブラリ名 --save


# <node_modulesがない場合package.jsonからライブラリをダウンロードする>
# npm install			// package.jsonのあるフォルダで

# ---------------------------------------------------------
# <パッケージマネージャーnpm>
# ローカルインストール：
# npm install モジュール（ライブラリ）名
# npm install モジュール名 --save		// package.jsonのdependencies(default有効)：プロジェクトの実行に必要なもの
# npm install モジュール名 --save-dev	// package.jsonのdevDependencies ：開発時のみ用いる依存関係

# グローバルインストール：
# npm install -g モジュール名

# モジュールのアンインストール
# npm uninstall モジュール名		// モジュールのアンインストール
# npm uninstall -g パッケージ名	// グローバルインストールパッケージをアンインストール
# npm uninstall パッケージ --save
# npm uninstall パッケージ --save-dev

# <グローバルパスの確認>
# npm root -g			// モジュールグローバルインストール先
# ※ g「グローバルインストール」と--save「ローカルインストール」は一緒に使えない
# ---------------------------------------------------------

#- npmのインストール
# sudo npm install -g npm
sudo npm install -g npm@9.5.1

cd $PWD/..

#- package.jsonの探索および実行分け
FIND_PACK=`find . -maxdepth 1 -name "package.json" -type f | wc -l`

#- package.jsonの作成
if [ $FIND_PACK -eq 0 ]; then
echo "package.jsonが無いので作成"
npm init
fi

# three.jsインストール
npm install --save three

# babel install
# トランスパイラ
# 最新のJavaScriptをサポートしないブラウザでも実行可能な形式にする
npm install --save-dev @babel/core @babel/preset-env
npm install --save-dev @babel/preset-typescript babel-loader

# webpack install
# モジュールバンドラ
# 画像、CSS、フォンとなどをバンドルし、効率的に管理する
# ネットワークリクエスト数を減らし、パフォーマンス向上
npm install --save-dev webpack webpack-cli webpack-dev-server html-webpack-plugin

# <webpack>
# // javascript css等を最適な形にまとめる
# // distフォルダ内にまとまったファイルが出力される
# // webpack.config.jsファイルを作成
# ※コマンドラインのオプションではなぜかうまくいかない

# webpack	        // 開発用にビルド
# webpack -p	    // 本番用に最適化してビルド
# webpack --watch	// 監視モードで差分ビルド

# 「手順」
# １．ソースディレクトリと出力ディレクトリを作成
# ２．「npm init」でpackage.jsonを作成
# ３．必要なモジュールインストール
# ４．webpack.config.jsを作成
# ５．ソースコードを作成、webpackコマンドでコンパイル
# ６．Webサーバー上でコンパイル結果確認


# typescript
npm install --save-dev typescript
npm install --save-dev ts-loader
npm install --save-dev @types/three

# 画像をコピーする
npm install copy-webpack-plugin --save-dev

fi