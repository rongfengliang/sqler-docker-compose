# sqler docker-compose running

## how to running

* build sqler image or use build version dalongrong/sqler:1.5

with env for running

support config vars (-config, -dsn, -rest,-resp,-driver,-workers)

```code
docker-compose build -t dalongrong/sqler:1.5 .
```

* running

```code
docker-compose up -d
```

##  post data

```code
curl -X POST \
  http://localhost:8025/adduser \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a7784ea1-9f50-46ee-92ac-1d850334f3f1' \
  -H 'cache-control: no-cache' \
  -d '{
	"user_name":"dalong",
	"user_email":"1141591465@qq.com",
	"user_password":"dalongdemo"
}'
```

result

```code
{
    "data": [
        {
            "ID": 1,
            "email": "1141591465@qq.com",
            "name": "dalong",
            "password": "$2a$10$nfPllaq3AqYDwu4SQTskWeN0BphHCoBzwmb4rj6Q0OB21voBHCZke",
            "time": 1547127497
        }
    ],
    "success": true
}
```