Engines Portal
==============

Engines user portal. Displays user shortcuts to apps and allows users to change password.

Framework
---------
Sinatra (module style, with config.ru)

Needs
-----
public directory: public   
persistent volume: data

/Uses activerecord and rake/
In production $DATABASE_URL environment variable will be read as the database

/Image processing/
System: Magick
(for dev in ubuntu: sudo apt-get install libmagickwand-dev )

config.ru
---------
require_relative 'v0/module'  
map('/') { run V0 }  

Environment
-----------
**Required**  
ENV['ENGINES_USER_PORTAL_SYSTEM_IP']
ENV['ENGINES_USER_PORTAL_SESSION_SECRET']

**Optional**  
ENV['ENGINES_USER_PORTAL_USER_INACTIVITY_TIMEOUT'] default is 30 (i.e. 30 minutes).
