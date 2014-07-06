#!/usr/bin/env bash

# start root shell
sudo -s
# Import neo4j signing key
wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - 
# Create an Apt sources.list file
echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
# Find out about the files in our repository
apt-get update
# Install Neo4j, community edition
apt-get install neo4j
# start neo4j server, available at http://localhost:7474 of the target machine
neo4j start
