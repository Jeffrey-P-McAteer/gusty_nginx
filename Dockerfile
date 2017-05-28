#FROM alpine
FROM amazonlinux

# Update system
RUN yum update -y && yum install -y vim

# Install nginx
RUN yum install -y nginx && \
	mkdir /www && \
	chown -R nginx:nginx /var/lib/nginx && \
	chown -R nginx:nginx /www

# Install Django
RUN yum install -y epel-release && \
	yum install -y python34 python34-setuptools && \
	easy_install-3.4 pip && \
	pip3 install Django

# Install uWSGI
RUN yum install -y gcc python34-devel && \
	pip3 install uwsgi

# Point /usr/bin/python at our python34 install
RUN rm /usr/bin/python && \
	ln -s /usr/bin/python34 /usr/bin/python

# Setup a demo Django site
RUN cd /www; django-admin.py startproject my_django_project && \
	cd /www/my_django_project; python34 manage.py startapp my_django_app

# Move our configuration files into container
COPY nginx.conf /etc/nginx/nginx.conf
COPY gusty-django.conf /etc/init/gusty-django.conf

# Additional config and setup
# Static root relative to project directory may be done with 'STATIC_ROOT = os.path.join(BASE_DIR, "static/")'
# Just make sure to update nginx.conf to match whatever that resolves to.
RUN echo 'STATIC_ROOT = "/www/my_django_project/static_files/"' >> /www/my_django_project/my_django_project/settings.py && \
	cd /www/my_django_project; echo yes | ./manage.py collectstatic && \
	chown -R nginx:nginx /www

CMD cd /www/my_django_project/; uwsgi --uid nginx --socket /tmp/uwsgi.sock --module my_django_project.wsgi >/tmp/uwsgi.log 2>&1 & \
	sleep 1 && \
	nginx >/tmp/nginx.log 2>&1 & \
	printf "\nNginx startup logs found in /tmp/nginx.log\nuWSGI startup logs found in /tmp/uwsgi.log\n\n"; sh
