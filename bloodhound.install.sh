#!/bin/bash

wget -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
echo 'deb http://debian.neo4j.org/repo stable/' > /tmp/neo4j.list
mv /tmp/neo4j.list /etc/apt/sources.list.d
apt-get update
apt-get install neo4j -y

wget https://github.com/adaptivethreat/BloodHound/releases/download/1.0.1/BloodHound-linux-x64.zip
unzip BloodHound-linux-x64.zip; rm BloodHound-linux-x64.zip
cd BloodHound-linux-x64
git clone https://github.com/adaptivethreat/bloodhound

cd bloodhound
cp -R BloodHoundExampleDB.graphdb /var/lib/neo4j/data/databases/graph.db
cd ..

# Check active_database in conf
head /etc/neo4j/neo4j.conf

neo4j start
echo 'Browse to localhost:7474'
echo 'Enter auth: neo4j | neo4j'
echo 'change new password to: BloodHound'
echo '...Then close the browser...'

echo 'Running BloodHound'
echo 'Web > http://localhost:7474'
echo 'Auth > neo4j | BloodHound'
echo 'Enjoy!'
chmod +x BloodHound
./BloodHound
