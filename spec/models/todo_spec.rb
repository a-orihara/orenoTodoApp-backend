# ファイル内のテストを実行する為には、railsアプリの読み込みが必要という意味
require 'rails_helper'

# describe （RSpec.describe）はテストのグループ化を宣言します。
# [Todo, type: :model]についてのテストを記述しますという意味
RSpec.describe Todo, type: :model do
  # it はテストを example という単位にまとめる役割をします。
  # 「1つの example につき1つのエクスペクテーション(it)」で書いた方がテストの保守性が良くなります。
  # it do ... end の中のエクスペクテーション（期待値と実際の値の比較）がすべてパスすれば、その example はパスしたことになります。
  it 'nameがないと登録出来ない' do
    # expect(X).to eq Y で記述するのがエクスペクテーションです。
    # expect(Post.new).not_to eq(nil)
  end
end

# 名がなければ無効な状態であること7it"isinvalidwithoutafirstname"
