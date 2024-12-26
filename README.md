## Step to Run

-   Ensure the .env file is properly configured with database credentials:

```bash
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=user
DB_PASSWORD=password
```

-   Build and start the containers:

```bash
docker-compose up --build -d
```

-   Check Laravel permissions: Inside the php container, run:

```bash
docker exec -it php chmod -R 775 /var/www/storage /var/www/bootstrap/cache
```

-   Generate Laravel keys: Inside the php container, run:

```bash
docker exec -it php php artisan key:generate
```

-   Migrate the database: Inside the php container, run:

```bash
docker exec -it php php artisan migrate
```

-   Access the application: Visit `http://localhost` in your browser.

## Expected Output

-   The Laravel application should load correctly.
-   If you encounter issues, check the logs:
    -   Nginx logs: docker exec -it nginx cat /var/log/nginx/error.log
    -   PHP logs: docker exec -it php cat /var/log/php-fpm.log
