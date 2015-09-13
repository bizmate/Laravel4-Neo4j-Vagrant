class neo4j
{

    apt::key { 'add neo4j key':
        key => '2DC499C3',
        ensure => 'present',
        key_source => 'http://debian.neo4j.org/neotechnology.gpg.key',
        before => Package['neo4j'],
    }

    file_line { 'add neo4j sources':
        path => '/etc/apt/sources.list',
        line => 'deb http://debian.neo4j.org/repo stable/',
        before => Package['neo4j'],
    }
    
    package { 'neo4j':
        ensure => latest,
        require => Exec['apt-get update'],
    }
    
    service { 'neo4j':
        name => 'neo4j-service',
        ensure => running,
        enable => true,
        #path => '/etc/init.d/neo4j-service',
        require => Package['neo4j'],
    }
    
    file_line { 'allow external neo4j access':
        notify => Service['neo4j'],
        path => '/etc/neo4j/neo4j-server.properties',
        line => 'org.neo4j.server.webserver.address=0.0.0.0',
        match => '^#?org.neo4j.server.webserver.address=0.0.0.0',
        require => Package['neo4j'],
    }

}
