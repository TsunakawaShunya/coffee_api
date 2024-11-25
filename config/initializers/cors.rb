# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 開発環境
    if Rails.env.development?
      origins "http://localhost:3000"  # ローカル開発環境のURLを指定
    end

    # 本番環境
    if Rails.env.production?
      origins "https://myapp-red-seven.vercel.app/"  # 本番環境のURLを指定
    end

    resource "*",
      headers: :any,
      expose: %w[access-token uid client],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
