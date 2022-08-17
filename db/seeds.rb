# This file should contain all the record creation needed to seed the database with its default values.
# <このファイルには、データベースにデフォルト値で種付けするために必要なすべてのレコード作成が含まれているはずです。>
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# <その後、bin/rails db:seedコマンドでデータをロードすることができます（または、db:setupでデータベースと一緒に作成します）。>

SAMPLE_TODOS = [
  {
    name: 'momoを食べる'
  },
  {
    name: 'kokoに行く'
  },
  {
    name: 'sasaに入る'
  }
]

SAMPLE_TODOS.each do |todo|
  Todo.create(todo)
end
