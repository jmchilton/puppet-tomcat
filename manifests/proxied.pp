class tomcat::proxied {
  include tomcat
  include apache

  a2mod { "Enable proxy mod":
    name => "proxy",
    ensure => "present"
  }

  a2mod { "Enable proxy_http mod":
    name => "proxy_http",
    ensure => "present"
  }

  apache::vhost::proxy { "apache proxy":
    port => 80,
    dest => "http://localhost:8080",
  }

}