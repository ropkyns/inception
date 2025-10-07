echo "Waiting for Mariadb to be ready..."
until mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
	echo "Mariadb is unvailable - sleeping"
	sleep 2
done
echo "MariaDB is up - executing command"

if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "WordPress already installed"
else
		
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress' --skip-check --allow-root
	wp core install \
		--path='/var/www/wordpress' \
		--url="https://$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_USER" \
		--admin_password="$WP_PASSWORD" \
		--admin_email="$WP_EMAIL" \
		--skip-email \
		--allow-root
	wp user create testo test@tes.to --role=author --path='/var/www/wordpress' --user_pass=testo --allow-root
fi

if wp user get admin --path='/var/www/wordpress' --allow-root > /dev/null 2>&1; then
	echo "Deleting user 'Admin'"
	wp user delete admin --path='/var/www/wordpress' --allow-root --yes
fi

if ! wp user get "$WP_USER" --path='/var/www/wordpress' --allow-root > /dev/null 2>&1; then
	echo "Creating admin user '$WP_USER'"
	wp user create "$WP_USER" "$WP_EMAIL" --role=administrator --user_pass="$WP_PASSWORD" --path='/var/www/wordpress' --allow-root
else
	echo "Admin user $WP_USER already exists."
fi

echo "Starting Php-fpm"
exec /usr/sbin/php-fpm8.2 -F