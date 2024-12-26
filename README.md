## Step to Run

-   Ensure the .env file is properly configured with database credentials for example:

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
