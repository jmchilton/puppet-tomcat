class tomcat(
  $tomcat_password        = undef,
  $tomcat_heap_size       = "2G",
  $tomcat_perm_size       = "156M",
) {

  include tomcat::params, tomcat::service

  class { "tomcat::install":
    tomcat_heap_size => $tomcat_heap_size,
    tomcat_perm_size => $tomcat_perm_size,
    tomcat_password  => $tomcat_password,
    tomcat_port      => $tomcat::params::port,
  }

}

define tomcat::deployment($path) {
  include tomcat
 
  exec { "wget-war-$name":
    command => "/usr/bin/wget --output-document=/var/lib/tomcat6/webapps/${name}.war $path",
    creates => "$destination",
  }
  
  #file { "/var/lib/tomcat6/webapps/${name}.war":
  #  owner  => 'root',
  #  source => $path,
  #}

}
