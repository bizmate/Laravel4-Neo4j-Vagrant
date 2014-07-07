class neo4j
{

    apt::key { 'add neo4j key':
        key => '2DC499C3',
        ensure => 'present',
        key_source => 'http://debian.neo4j.org/neotechnology.gpg.key',
    }

    file_line { 'add neo4j sources':
        path => '/etc/apt/sources.list',
        line => 'deb http://debian.neo4j.org/repo stable/',
    }
    
    package { 'neo4j':
        ensure => latest,
        require => Exec['apt-get update'],
    }

}
