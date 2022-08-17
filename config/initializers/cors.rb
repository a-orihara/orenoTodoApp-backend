# Be sure to restart your server when you modify this file.
# このファイルを変更した際には、必ずサーバーを再起動してください。

# Avoid CORS issues when API is called from the frontend app.
# フロントエンドアプリからAPIが呼び出された際のCORS問題を回避する。
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.
# クロスオリジンのAJAXリクエストを受け入れるために、Cross-Origin Resource Sharing（CORS）を処理します。

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # originを文字列で設定
    # 3000からこのrails apiへの通信を許可
    origins 'http://localhost:3000'

    resource '*',
             headers: :any,
             # どのようなHTTPリクエストを許可するのか？をここで設定できます。
             methods: %i[get post put patch delete options head]
  end
end
