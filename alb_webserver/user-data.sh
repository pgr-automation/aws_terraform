#! /bin/bash

yum install nginx -y

systemctl start nginx

cat <<EOL /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to NGINX</title>
</head>
<body>
    <h1>Success! The NGINX server is working $(hostname)!</h1>
</body>
</html>

EOL