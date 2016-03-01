Build container:
git clone https://github.com/Edelskjold/docker-tools
docker build -t edelskjold/apache2 .

Run container:
docker run -p 81:80 -d -v /srv/webadmin:/var/www/site edelskjold/apache2
