name             'sqlserver'
source_url       'https://github.com/tsubauaaa/sqlserver-chef' if respond_to?(:source_url)
issues_url       'https://github.com/tsubauaaa/sqlserver-chef' if respond_to?(:issues_url)
maintainer       'Tsubasa Hirota'
maintainer_email 'tsubasa1173@gmail.com'
license          'All rights reserved'
description      'Installs/Configures SQL Server for windows'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
