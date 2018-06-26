
server ENV['SSH_SERVER_IP'], user: ENV['SSH_SERVER_USER'], roles: %w{app db web}, port: ENV['SSH_SERVER_PORT'] 

#デプロイするサーバーにsshログインする鍵の情報。サーバー編で作成した鍵のパス
set :ssh_options, keys: ENV['SSH_SERVER_KEYS']
