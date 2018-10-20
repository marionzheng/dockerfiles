FROM alpine
MAINTAINER Marion "trboyspace@126.com"

# /usr/local/nginx/nginx.conf -> /conf/*.conf -> servers config
#
# Build:
# docker build -f ./tengine/Dockerfile -t my_nginx .
# Run:
# docker run -d --name=my_nginx \
#            -p 8088:80 -p 8443:443 \
#            -v $PWD/tengine/test/:/conf \
#            -v $PWD/tengine/logs:/usr/local/nginx/logs \
#            -v your_web_sites_home:/opt/www \
#            -e UrlDeny=on -e CCDeny=off -e CCrate="100/60" -e CookieMatch=on -e PostMatch=off -e ReplayDeny=off \
#            -e IPWhitelist="\"127.0.0.1\"" -e IPBlocklist="\"1.0.0.1\"" \
#            -e UrlWhitelist="" \
#            -e UrlPrefixBlocklist="\"api\", \"service\"" \
#            my_nginx
#
# Test:
# docker run -d --name=temp -p 8088:80 -p 8443:443 -v $PWD/tengine/test/:/conf -v $PWD/tengine/logs:/usr/local/nginx/logs -e UrlPrefixBlocklist="'api', 'service'" my_nginx
# docker exec -it temp /bin/bash

ADD ./tengine/tengine-2.2.2.tar.gz /root/
ADD ./tengine/headers-more-nginx-module-0.33.tar.gz /root/
ADD ./tengine/LuaJIT-2.0.5.tar.gz /root/
ADD ./tengine/openssl-1.0.2p.tar.gz /root/
COPY ./tengine/ngx_lua_waf-master.zip /root/
COPY ./tengine/docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk update \
    && apk --update --no-cache add curl tcpdump strace bash-completion tree tzdata linux-headers \
    pcre-dev openssl openssl-dev libxslt-dev gd-dev lua-dev geoip-dev g++ make unzip tini \
    && rm -rf /var/cache/apk/* \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && cd /root/LuaJIT-2.0.5 \
    && make && make install PREFIX=/usr/local/luajit \
    && cd /root/tengine-2.2.2 \
    && ./configure --add-module=/root/headers-more-nginx-module-0.33 --with-http_lua_module \
    --with-luajit-lib=/usr/local/luajit/lib/ --with-luajit-inc=/usr/local/luajit/include/luajit-2.0/ \
    --with-ld-opt=-Wl,-rpath,/usr/local/luajit/lib --with-openssl=/root/openssl-1.0.2p \
    && make && make install \
    && cd /root \
    && unzip /root/ngx_lua_waf-master.zip \
    && mv /root/ngx_lua_waf-master /usr/local/nginx/conf/waf \
    && rm -rf /root/LuaJIT-2.0.5 /root/headers-more-nginx-module-0.33 /root/ngx_lua_waf-master.zip /root/openssl-1.0.2p /root/tengine-2.2.2 \
    && mkdir -p /usr/local/nginx/html
COPY ./tengine/conf/nginx.conf /usr/local/nginx/conf/
COPY ./tengine/conf/config.lua /usr/local/nginx/conf/waf/
COPY ./tengine/conf/init.lua /usr/local/nginx/conf/waf/
COPY ./tengine/conf/waf.lua /usr/local/nginx/conf/waf/
COPY ./tengine/conf/404.html /usr/local/nginx/html/
COPY ./tengine/conf/50x.html /usr/local/nginx/html/
WORKDIR /usr/local/nginx
ENV LANG C.UTF-8
ENV PATH $PATH:/usr/local/nginx/sbin:/sbin
ENV UrlDeny on
ENV CCDeny off
ENV CCrate "100/60"
ENV CookieMatch on
ENV PostMatch off
ENV ReplayDeny off
ENV IPWhitelist "\"127.0.0.1\""
ENV IPBlocklist "\"1.0.0.1\""
ENV UrlWhitelist ""
ENV UrlPrefixBlocklist "\"service\""
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["nginx", "-c", "/usr/local/nginx/conf/nginx.conf", "-g", "daemon off;"]