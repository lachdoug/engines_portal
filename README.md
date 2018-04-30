Engines Portal
==============

Engines user portal. Displays user shortcuts to apps and allows users to change password.

Framework
---------
Sinatra (module style, with config.ru)

Needs
-----
public directory: public   
Note: does not need a DB or volumes and does not send mail.

config.ru
---------
require_relative 'v0/module'  
map('/') { run V0 }  

Environment
-----------
**Required**  
ENV['ENGINES_USER_PORTAL_SYSTEM_IP']

**Optional**  
ENV['ENGINES_USER_PORTAL_USER_INACTIVITY_TIMEOUT'] default is 30 (i.e. 30 minutes).  
