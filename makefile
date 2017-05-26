.PHONY: gusty_nginx

gusty_nginx:
	docker build . -t jeffreypmcateer/gusty_nginx

# Forwards port 8080 on the container to 8080 on localhost
# Runs interactivelly, so we can have a shell while things run.
run: gusty_nginx
	docker run -p 8080:8080 -it jeffreypmcateer/gusty_nginx

clean:
	yes | docker system prune
	docker rmi jeffreypmcateer/gusty_nginx
