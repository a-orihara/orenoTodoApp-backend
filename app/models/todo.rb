class Todo < ApplicationRecord
  # =validates(:name, presence: true)
  validates :name, presence: true, length: { maximum: 20 }
end

# validatesdやらないとエラーメッセージが出ない
# valid?で失敗するとerrorsオブジェクトが作られる。
