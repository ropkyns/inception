echo "Waiting for Mariadb to be ready..."
until mysqladmin ping -h mariadb --silent; do
	echo "Mariadb is unvailable - sleeping"
	sleep 3
done
echo "MariaDB is up - executing command"

if [ -f "/var/www/html/wp-config.php" ]; then
	echo "WordPress already installed"
else
	if [ ! -x /usr/local/bin/wp ]; then
		echo "wordpress cli installation"
		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
		chmod +x /usr/local/bin/wp

	fi

	wp core download --path=/var/www/html --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path=/var/www/html --skip-check --allow-root
	wp core install \
		--path=/var/www/html \
		--url="https://$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_USER" \
		--admin_password="$WP_PASSWORD" \
		--admin_email="$WP_EMAIL" \
		--skip-email \
		--allow-root
	# wp user create testo test@tes.to --role=author --path=/var/www/html --user_pass=testo --allow-root
fi

if wp user get admin --path=/var/www/html --allow-root > /dev/null 2>&1; then
	echo "Deleting user 'Admin'"
	wp user delete admin --path=/var/www/html --allow-root --yes
fi

if ! wp user get "$WP_USER" --path=/var/www/html --allow-root > /dev/null 2>&1; then
	echo "Creating admin user '$WP_USER'"
	wp user create "$WP_USER" "$WP_EMAIL" --role=administrator --user_pass="$WP_PASSWORD" --path=/var/www/html --allow-root
else
	echo "Admin user $WP_USER already exists."
fi

echo "Starting Php-fpm"
exec /usr/sbin/php-fpm8.2 -F