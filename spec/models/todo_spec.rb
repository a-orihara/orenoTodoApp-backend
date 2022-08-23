# ファイル内のテストを実行する為には、railsアプリの読み込みが必要という意味
require 'rails_helper'

# describe （RSpec.describe）はテストのグループ化を宣言します。
# [Todo, type: :model]についてのテストを記述しますという意味
RSpec.describe Todo, type: :model do
  # before で共通の前準備をする
  # before do ... end で囲まれた部分は example の実行前に毎回呼ばれます。
  before do
    # 各テストコードが実行される前にFactoryBotで生成したインスタンスを@userに代入
    # FactoryBot.buildとcreateの違いは下記
    @todo = FactoryBot.build(:todo)
    # ↑こういう書き方もあり：user=FactoryBot.build(:user,first_name:nil)
  end

  # it はテストを example という単位にまとめる役割をします。
  # 「1つの example につき1つのエクスペクテーション(it)」で書いた方がテストの保守性が良くなります。
  # it do ... end の中のエクスペクテーション（期待値と実際の値の比較）がすべてパスすれば、その example はパスしたことになります。
  it 'nameがないと登録出来ない' do
    @todo.name = ''
    # valid?:バリデーションが実行された結果,エラーが無い場合true,エラーが発生した場合falseを返す
    @todo.valid?
    # expect(X).to eq Y で記述するのがエクスペクテーションです。
    # include(マッチャ):Xの中にYという文字列が含まれているか
    expect(@todo.errors.full_messages).to include("Name can't be blank")
  end

  it 'nameで20文字以上の文字は登録出来ない' do
    # valid?:バリデーションが実行された結果,エラーが無い場合true,エラーが発生した場合falseを返す
    @todo.valid?
    # expect(X).to eq Y で記述するのがエクスペクテーションです。
    # include(マッチャ):Xの中にYという文字列が含まれているか
    expect(@todo.errors.full_messages).to include('Name is too long (maximum is 20 characters)')
  end
end

# *describeメソッド、contextメソッド、itメソッド
# テストコードのグループ分けに使用するメソッドで、describeメソッドはどのような機能なのか（テスト対象）,
# contextメソッドはどのような状況なのか, itメソッドは何をテストしているのかをそれぞれグループ分けしています。

# マッチャ（matcher）は「期待値と実際の値を比較して、一致した（もしくは一致しなかった）という結果を返すオブジェクト」のこと

# build
# メモリ上にインスタンスを確保する。
# DB上にはデータがないので、DBにアクセスする必要があるテストのときは使えない。
# DBにアクセスする必要がないテストの時には、インスタンスを確保する時にDBにアクセスする必要がないので処理が比較的軽くなる。

# create
# DB上にインスタンスを永続化する。
# DB上にデータを作成する。
# DBにアクセスする処理のときは必須。（何かの処理の後、DBの値が変更されたのを確認する際は必要）
