sleep 10
if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "WordPress already installed"
else
	wp core download --path='/var/www/wordpress' --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress' --skip-check --allow-root
	wp core install --path='/var/www/wordpress' --url="https://$DOMAIN_NAME" --title="$WP_TITLE" --skip-email --allow-root
	wp user create testo test@tes.to --role=author --path='/var/www/wordpress' --user_pass=testo --allow-root
fi

if wp user get admin --path='/var/www/wordpress' --allow-root > /dev/null 2>&1; then
	echo "Deleting user 'Admin'"
	wp user delete admin --path='/var/www/wordpress' --allow-root --yes
fi

if ! wp user get $WP_USER --path='/var/www/wordpress' --allow-root > /dev/null 2>&1; then
	echo "Creating admin user '$WP_USER'"
	wp user create $WP_USER $WP_EMAIL --role=administrator --user_pass=$WP_PASSWORD --path='/var/www/wordpress' --allow-root
else
	echo "Admin user $WP_USER already exists."
fi

echo "Starting Php-fpm"
exec /usr/sbin/php-fpm8.2 -F