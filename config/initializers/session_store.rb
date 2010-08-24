# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pin-workspace_session',
  :secret      => '53e8022f340999aff6eef91c58156f66a389f30bb436966eab65e6536c0940c439b68357cd012573dcbe7e2863f05d046c2568a83f21380e1da18a875c155a93'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
