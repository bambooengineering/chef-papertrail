maintainer       "First Banco"
maintainer_email "rob@firstbanco.com"
license          "All rights reserved"
description      "Installs/Configures papertrail"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
depends         "build-essential"
depends          "rsyslog"

supports "ubuntu"
supports "debian"