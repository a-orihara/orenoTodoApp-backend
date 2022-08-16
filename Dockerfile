# rubyのバージョン指定.この中に初めからOSも入っている
# ruby2系安定版はruby2.7.6。3系は3.1.2。
FROM ruby:3.1.2
# railsに必要なnodejsとyarn、mysqlをインストールしています
# nodejsとyarnはwebpackをインストールする際に必要
# レポジトリがシステムに加えられたらパッケージリストをアップデートしてからYarnをインストールする
# -qq:quietモードで実行。ログを極力表示させない。エラー以外を表示しないオプションです。
# build-essential:開発に必須のビルドツールを提供しているパッケージ。
# ／gcc(GNU C Compiler)とかg++(GNU C++ Compiler), makeとかその他色々入るらしい。
# nodejs:nodejsをインストール
RUN apt-get update -qq \
  && apt-get install -y build-essential nodejs yarn
# rails_appディレクトリを作成
RUN mkdir /rails_app

# 作業ディレクトリを設定。
# ここで指定したディレクトリが、その後のDockerfile内でのRUN,COPYなどのあらゆる命令の起点となります。
WORKDIR /rails_app
COPY Gemfile /rails_app/Gemfile
COPY Gemfile.lock /rails_app/Gemfile.lock

# WORKDIR /myappにてbundle installを実行
# 再ビルド時にbundle installするために記載
RUN bundle install

# カレントディレクトリ(ローカルのmyapp)を、コンテナ内のmyappへコピーする。
# COPY a b :aをbにコピーする
# DockerfileでCOPYかADDをするときにホスト側は絶対パスだとエラーになる
# DockerfileでCOPYするときはホスト側のpathはdocker build時に指定したディレクトリからの相対パスで指定
COPY . /rails_app

# (COPY~RUN~ENTRYPOINT)コンテナー起動時に毎回実行されるスクリプトを追加
# コンテナルート/usr/bin/にentrypoint.shをコピー
# entrypoint.shにはコンテナ立ち上げ時に実行するスクリプトを書く
# /usr/bin/はコンテナのLinuxベースのディレクトリ
COPY entrypoint.sh /usr/bin/
# entrypoint.shの権限(+x:すべてのユーザーに実行権限を追加)を変更
RUN chmod +x /usr/bin/entrypoint.sh
# 一番最初に実行するコマンド.ENTRYPOINTを複数書いても、Dockerfile中で一番最後の命令しか処理されません。
# ENTRYPOINTは、コンテナを実行ファイル(executable)として処理するように設定できます。
# exec形式を公式で推奨。shell形式では、CMDやrunコマンドラインの引数を使えません。
# ENTRYPOINTのexec形式は、確実に実行するデフォルトのコマンドと引数を設定するために使います。
# 複数のコマンドが必要な場合は、シェルスクリプトから実行する
ENTRYPOINT ["entrypoint.sh"]

# "コンテナ"がホストに対してリッスンするport番号を3000に設定する。
EXPOSE 3000

# 1.イメージのベースにrubyを指定
# 2.node、yarnをインストール
# 3.コンテナのルートディレクトリ直下にmyappディレクトリを作成し、作業ディレクトリに指定
# *myappディレクトリにビルドコンテキスト（appのルートディレクトリ直下）内のGemfileとGemfile.lockをコピー
# *myappディレクトリのGemfileにgem railsを記載
# 4.コンテナルートディレクトリ直下のmyappにてbundle installを実行.
# *コンテナルートディレクトリ直下のmyappにrailsとその他ファイル群、gemfile更新
# *それが共有しているローカルのビルドコンテキスト直下のファイルに反映
# 5.コンテナルート/usr/bin/にentrypoint.shをコピーし、そのファイル権限を変更
# 6.コンテナルート/usr/bin/entrypoint.shのコマンドを実行。最終的にexec "$@"(CMD)を実行