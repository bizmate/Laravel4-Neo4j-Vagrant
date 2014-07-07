class neo4j
{

    apt::key { 'add neo4j key':
        key => '2DC499C3',
        ensure => 'present',
        key_source => 'http://debian.neo4j.org/neotechnology.gpg.key',
        Before => Package['neo4j'],
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
    
    file_line { 'allow external neo4j access':
        path => '/etc/neo4j/neo4j-server.properties',
        line => 'org.neo4j.server.webserver.address=0.0.0.0'
        match => '#org.neo4j.server.webserver.address=0.0.0.0'
        require => Package['neo4j'],
    }

}
