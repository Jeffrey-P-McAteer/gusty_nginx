FROM alpine


# Install nginx
RUN apk update && \
	apk add nginx && \
	adduser -D -u 1000 -g www www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

COPY nginx.conf /etc/nginx/nginx.conf
COPY site_a /www/site_a/
COPY site_b /www/site_b/

RUN chown -R www:www /www

CMD nginx >/tmp/nginx.log 2>&1 & echo "Nginx startup logs found in /tmp/nginx.log"; sh
