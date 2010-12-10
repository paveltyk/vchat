# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vchat_session',
  :secret      => 'e249f1cb0af39ace89ce4dc3db66508d2cce36a8e9e95ffdb000cbd3c342a19442cb4d4fd0b4664b30ff613eb65400e0847142283d60f1a0de1bcee76586df75'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
