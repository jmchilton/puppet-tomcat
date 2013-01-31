class tomcat::install(
  $tomcat_password  = undef,
  $tomcat_heap_size = "2G",
  $tomcat_perm_size = "156M",
  $tomcat_port      = 8080,
) {

  include tomcat::params

  notice("Establishing http://$hostname:$tomcat_port/")

  Package { # defaults
    ensure => installed,
  }

  package { 'tomcat6':
  }

  package { 'tomcat6-user':
    require => Package['tomcat6'],
  }
 
  package { 'tomcat6-admin':
    require => Package['tomcat6'],
  }

  if $tomcat_password != undef {

    file { "/etc/tomcat6/tomcat-users.xml":
      owner => 'root',
      require => Package['tomcat6'],
      notify => Service['tomcat6'],
      content => template('tomcat/tomcat-users.xml.erb')
    }

  }

  file { "/etc/default/tomcat6":
    owner => 'root',
    mode => '644',
    notify => Service['tomcat6'],
    content => template('tomcat/tomcat6_environment.sh.erb')
  }

  file { "/usr/share/tomcat6/":
    owner => $tomcat::params::web_user,
    mode => '700'
  }

  file { '/etc/tomcat6/server.xml':
     owner => 'root',
     require => Package['tomcat6'],
     notify => Service['tomcat6'],
     content => template('tomcat/server.xml.erb'),
  }

  file { '/etc/tomcat6/context.xml':
     owner => 'root',
     require => Package['tomcat6'],
     notify => Service['tomcat6'],
     content => template('tomcat/context.xml.erb'),
  }

  if $tomcat_temp_dir != undef {

    file { $tomcat_temp_dir:
      owner  => $tomcat::params::web_user,
      mode   => '700',
      ensure => directory,
    }

  }

}
