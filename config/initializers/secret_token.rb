# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Fabfoundation::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '9fe4db601705007f4c23c743e6e4e4b8678dfc2c1ad90da92bccfe853101225af1fc372e84267267c5890f40cf3049dc26f16a911cb3f4322886b004288ce359'
