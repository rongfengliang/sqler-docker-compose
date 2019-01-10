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

## search all insert datas

```code
curl -v http://localhost:8025/allusers | jq
```
result

```code
curl -v http://localhost:8025/allusers | jq

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8025 (#0)
> GET /allusers HTTP/1.1
> Host: localhost:8025
> User-Agent: curl/7.54.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
< Content-Type: application/json; charset=UTF-8
< Vary: Origin
< Vary: Accept-Encoding
< Date: Thu, 10 Jan 2019 14:16:05 GMT
< Content-Length: 315
< 
{ [315 bytes data]
100   315  100   315    0     0  26018      0 --:--:-- --:--:-- --:--:-- 26250
* Connection #0 to host localhost left intact
{
  "data": [
    {
      "ID": 1,
      "email": "1141591465@qq.com",
      "name": "dalong",
      "password": "$2a$10$nfPllaq3AqYDwu4SQTskWeN0BphHCoBzwmb4rj6Q0OB21voBHCZke",
      "time": 1547127497
    },
    {
      "ID": 2,
      "email": "1141591465@qq.com",
      "name": "dalong",
      "password": "$2a$10$Msjxekb9ZJ7gXi4tPJTX0.xqLZa3u7mYODYnPfovvtvuIarQDHmmC",
      "time": 1547129263
    }
  ],
  "success": true
}

```