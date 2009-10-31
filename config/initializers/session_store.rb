# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rrrer2009_session',
  :secret      => '364b3a2d55ed2abcafb02107db881de0b980f9b2d75ec7cd839ae960ba82897f7fa778b4aca2960489565e04b9f4559ab3075d9de646df193252eb7c4f314484'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
