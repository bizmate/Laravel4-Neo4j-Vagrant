class neo4j
{

    apt::key { 'neo4j':
        ensure => 'present',
        key_source => 'http://debian.neo4j.org/neotechnology.gpg.key'
    }

    file_line { 'sudo_rule':
        path => '/etc/apt/sources.list',
        line => 'deb http://debian.neo4j.org/repo stable/',
    }
    
    package { 'neo4j':
        ensure => latest,
        require => Exec['apt-get update'],
        logoutput => true
    }

    exec { 'start neo4j':
        command => "/bin/bash -c 'neo4j start'",
        require => Package["neo4j"],
        timeout => 5000,
        logoutput => true
    }

}
