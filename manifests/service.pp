class tomcat::service {

  service { 'tomcat6':
    ensure  => running,
    require => Class["tomcat::install"],
  }

}
