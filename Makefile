up: docker-up

docker-up:
	docker-compose up --build -d

docker-clear:
	docker-compose down --remove-orphans

bitrix-setup:
	docker-compose exec php-fpm-cli wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -O bitrixsetup.php
	make perm

bitrix-restore-download:
	docker-compose exec php-fpm-cli wget $(url)
	make perm

bitrix-restore: bitrix-restore-download
	docker-compose exec php-fpm-cli wget http://www.1c-bitrix.ru/download/scripts/restore.php -O restore.php
	make perm

composer:
	docker-compose exec php-fpm-cli composer install

perm:
	docker-compose exec php-fpm chgrp -R ${USER} www
	docker-compose exec php-fpm chown -R ${USER}:${USER} www
	docker-compose exec php-fpm chmod -R ug+rwx www
