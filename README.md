## Step to Run

-   Ensure the .env file is properly configured with database credentials for example:

```bash
# Database configuration
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=user
DB_PASSWORD=password

# MySQL root password
MYSQL_ROOT_PASSWORD=secret
MYSQL_DATABASE=laravel
MYSQL_USER=user
MYSQL_PASSWORD=password
```

-   Build and start the containers:

```bash
docker-compose up --build -d
```
