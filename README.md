Description
===========

Installs, configures and starts remote_syslog, the syslog gem from papertrail.

Attributes
==========

The following attributes are provided (with these defaults)

    default[:papertrail][:remote_syslog][:version] = '1.6.5'
    default[:papertrail][:host] = 'logs.papertrailapp.com'
    default[:papertrail][:port] = '514'
    default[:papertrail][:logs] = []
    default[:papertrail][:exclude_patterns] = []


Usage
=====

There is just one recipe, so use:

    recipe['papertrail']
