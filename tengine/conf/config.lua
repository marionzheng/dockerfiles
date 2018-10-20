RulePath = "/usr/local/nginx/conf/waf/wafconf/"
attacklog = "on"
logdir = "/usr/local/nginx/logs/hack/"
UrlDeny = "on"
Redirect = "on"
CookieMatch = "on"
postMatch = "off"
whiteModule = "on"
black_fileExt = { "php", "jsp" }
ipWhitelist = { "127.0.0.1" }
ipBlocklist = { "1.0.0.1" }
urlWhitelist = {}
urlPrefixBlocklist = { "service" }
CCDeny = "on"
CCrate = "100/60"
ReplayDeny = "off"
html = [[
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="format-detection" content="telephone=no" />
    <title>403 Forbidden</title>
    <link href="img/favicon.ico" type="image/x-icon" rel=icon>
    <link href="img/favicon.ico" type="image/x-icon" rel="shortcut icon">
</head>
<body>
    <h1>Forbidden</h1>
    <span>You don't have permission to access / on this server.</span>
</body>
</html>
]]
