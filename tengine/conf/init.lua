require 'config'
local match = string.match
local ngxmatch = ngx.re.match
local unescape = ngx.unescape_uri
local get_headers = ngx.req.get_headers
local optionIsOn = function(options) return options == "on" and true or false end
logpath = logdir
rulepath = RulePath
UrlDeny = optionIsOn(UrlDeny)
PostCheck = optionIsOn(postMatch)
CookieCheck = optionIsOn(cookieMatch)
WhiteCheck = optionIsOn(whiteModule)
PathInfoFix = optionIsOn(PathInfoFix)
attacklog = optionIsOn(attacklog)
CCDeny = optionIsOn(CCDeny)
ReplayDeny = optionIsOn(ReplayDeny)
Redirect = optionIsOn(Redirect)
function getClientIp()
    IP = ngx.var.remote_addr
    if IP == nil then
        IP = "unknown"
    end
    return IP
end

function write(logfile, msg)
    local fd = io.open(logfile, "ab")
    if fd == nil then return end
    fd:write(msg)
    fd:flush()
    fd:close()
end

function log(method, url, data, ruletag)
    if attacklog then
        local realIp = getClientIp()
        local ua = ngx.var.http_user_agent
        local servername = ngx.var.server_name
        local time = ngx.localtime()
        if ua then
            line = realIp .. " [" .. time .. "] \"" .. method .. " " .. servername .. url .. "\" \"" .. data .. "\"  \"" .. ua .. "\" \"" .. ruletag .. "\"\n"
        else
            line = realIp .. " [" .. time .. "] \"" .. method .. " " .. servername .. url .. "\" \"" .. data .. "\" - \"" .. ruletag .. "\"\n"
        end
        local filename = logpath .. '/' .. servername .. "_" .. ngx.today() .. "_sec.log"
        write(filename, line)
    end
end

------------------------------------ 规则读取函数-------------------------------------------------------------------
function read_rule(var)
    file = io.open(rulepath .. '/' .. var, "r")
    if file == nil then
        return
    end
    t = {}
    for line in file:lines() do
        table.insert(t, line)
    end
    file:close()
    return (t)
end

urlrules = read_rule('url')
argsrules = read_rule('args')
uarules = read_rule('user-agent')
wturlrules = read_rule('whiteurl')
postrules = read_rule('post')
ckrules = read_rule('cookie')


function say_html()
    if Redirect then
        ngx.header.content_type = "text/html"
        ngx.status = ngx.HTTP_FORBIDDEN
        ngx.say(html)
        ngx.exit(ngx.status)
    end
end

function whiteurl()
    if WhiteCheck then
        if wturlrules ~= nil then
            for _, rule in pairs(wturlrules) do
                if ngxmatch(ngx.var.uri, rule, "isjo") then
                    return true
                end
            end
        end
    end
    return false
end

function fileExtCheck(ext)
    local items = Set(black_fileExt)
    ext = string.lower(ext)
    if ext then
        for rule in pairs(items) do
            if ngx.re.match(ext, rule, "isjo") then
                log('POST', ngx.var.request_uri, "-", "file attack with ext " .. ext)
                say_html()
            end
        end
    end
    return false
end

function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function args()
    for _, rule in pairs(argsrules) do
        local args = ngx.req.get_uri_args()
        for key, val in pairs(args) do
            if type(val) == 'table' then
                local t = {}
                for k, v in pairs(val) do
                    if v == true then
                        v = ""
                    end
                    table.insert(t, v)
                end
                data = table.concat(t, " ")
            else
                data = val
            end
            if data and type(data) ~= "boolean" and rule ~= "" and ngxmatch(unescape(data), rule, "isjo") then
                log('GET', ngx.var.request_uri, "-", rule)
                say_html()
                return true
            end
        end
    end
    return false
end


function url()
    if UrlDeny then
        for _, rule in pairs(urlrules) do
            if rule ~= "" and ngxmatch(ngx.var.request_uri, rule, "isjo") then
                log('GET', ngx.var.request_uri, "-", rule)
                say_html()
                return true
            end
        end
    end
    return false
end

function ua()
    local ua = ngx.var.http_user_agent
    if ua ~= nil then
        for _, rule in pairs(uarules) do
            if rule ~= "" and ngxmatch(ua, rule, "isjo") then
                log('UA', ngx.var.request_uri, "-", rule)
                say_html()
                return true
            end
        end
    end
    return false
end

function body(data)
    for _, rule in pairs(postrules) do
        if rule ~= "" and data ~= "" and ngxmatch(unescape(data), rule, "isjo") then
            log('POST', ngx.var.request_uri, data, rule)
            say_html()
            return true
        end
    end
    return false
end

function cookie()
    local ck = ngx.var.http_cookie
    if CookieCheck and ck then
        for _, rule in pairs(ckrules) do
            if rule ~= "" and ngxmatch(ck, rule, "isjo") then
                log('Cookie', ngx.var.request_uri, "-", rule)
                say_html()
                return true
            end
        end
    end
    return false
end

function denycc()
    if CCDeny then
        local uri = ngx.var.uri
        CCcount = tonumber(string.match(CCrate, '(.*)/'))
        CCseconds = tonumber(string.match(CCrate, '/(.*)'))
        local token = getClientIp() .. uri
        local limit = ngx.shared.limit
        local req, _ = limit:get(token)
        if req then
            if req > CCcount then
                ngx.exit(503)
                return true
            else
                limit:incr(token, 1)
            end
        else
            limit:set(token, 1, CCseconds)
        end
    end
    return false
end

function get_boundary()
    local header = get_headers()["content-type"]
    if not header then
        return nil
    end

    if type(header) == "table" then
        header = header[1]
    end

    local m = match(header, ";%s*boundary=\"([^\"]+)\"")
    if m then
        return m
    end

    return match(header, ";%s*boundary=([^\",;]+)")
end

function whiteip()
    if next(ipWhitelist) ~= nil then
        for _, ip in pairs(ipWhitelist) do
            if getClientIp() == ip then
                return true
            end
        end
    end
    return false
end

function blockip()
    if next(ipBlocklist) ~= nil then
        for _, ip in pairs(ipBlocklist) do
            if getClientIp() == ip then
                say_html()
                return true
            end
        end
    end
    return false
end

function check_referer()
    local referer = ngx.var.valid_referers
    local ua = ngx.var.http_user_agent
    local exts = [[\.(gif|jpg|jpeg|png|bmp|ico|tiff|tif|js|css|swf|doc|docx|xls|xlsx|pdf)$]]
    local http = "http"
    if ngx.var.https == "on" then http = "https" end
    local white_referer = {[0] = [[^]]..http..[[://[^/]*]]..ngx.var.host..[[[^/]*/.*]], [1] = [[^https?://[^/]*google\.com[^/]*/.*]], [2] = [[^https?://[^/]*baidu\.com[^/]*/.*]]}
    local white_ua = {[0] = "googlebot", [1] = "spider"}
    if referer ~= nil and ngxmatch(ngx.var.request_filename, exts,"ijos") then
        for rex in white_referer do
            if ngxmatch(referer, rex, "ijos") then return true end
        end
        if ua ~= nil then
            local lowerUA = string.lower(ua)
            for rex in white_ua do
                if ngxmatch(lowerUA, rex, "ijos") then return true end
            end
        end
        say_html()
    end
    return false
end

function url_need_check()
    if next(urlPrefixBlocklist) ~= nil then
        local flag = false
        for _, urlPrefix in pairs(urlPrefixBlocklist) do
            if ngxmatch(ngx.var.uri,"^\\/" + urlPrefix,"isjo") then
                flag = true
                break
            end
        end
        if flag then
            if next(urlWhitelist) ~= nil then
                for _,nck in pairs(urlWhitelist) do
                    if ngx.var.uri == nck then return false end
                end
            end
            return true
        end
    end
    return false
end

function denyreplay()
    if ReplayDeny and url_need_check() then
        local t = ngx.var['arg_t']
        if t ~= nil then
            t = t/1000
            local time = ngx.time()
            if (t-time) < -300 or (t-time) > 300 then
                say_html()
                return true
            end
        else
            say_html()
            return true
        end
    end
    return false
end