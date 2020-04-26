# Use the standard Nginx image from Docker Hub
FROM nginx


# install python, uwsgi, and supervisord
RUN apt-get update && apt-get install -y supervisor uwsgi python python-pip procps vim && \
    /usr/bin/pip install uwsgi==2.0.17 flask==1.0.2

# Copy the configuration file from the current directory and paste
# it inside the container to use it as Nginx's default config.
COPY nginx.conf /etc/nginx/nginx.conf

# setup NGINX config
RUN mkdir -p /spool/nginx /run/pid && \
    chmod -R 777 /var/log/nginx /var/cache/nginx /etc/nginx /var/run /run /run/pid /spool/nginx && \
    chgrp -R 0 /var/log/nginx /var/cache/nginx /etc/nginx /var/run /run /run/pid /spool/nginx && \
    chmod -R g+rwX /var/log/nginx /var/cache/nginx /etc/nginx /var/run /run /run/pid /spool/nginx && \
    rm /etc/nginx/conf.d/default.conf

# Copy the base uWSGI ini file to enable default dynamic uwsgi process number
COPY uwsgi.ini /etc/uwsgi/apps-available/uwsgi.ini
RUN ln -s /etc/uwsgi/apps-available/uwsgi.ini /etc/uwsgi/apps-enabled/uwsgi.ini

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN touch /var/log/supervisor/supervisord.log

# Sprinkle the fairy dust
EXPOSE 8989:8989
ENV SERVICE_HOME="/app/pyserver"
RUN mkdir -p ${SERVICE_HOME}
#ADD . ${SERVICE_HOME}

# setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# https://github.com/moby/moby/issues/31243#issuecomment-406879017
RUN ln -s /usr/local/bin/docker-entrypoint.sh / && \
    chmod 777 /usr/local/bin/docker-entrypoint.sh && \
    chgrp -R 0 /usr/local/bin/docker-entrypoint.sh && \
    chown -R nginx:root /usr/local/bin/docker-entrypoint.sh

# https://docs.openshift.com/container-platform/3.3/creating_images/guidelines.html
RUN chgrp -R 0 /var/log /var/cache /run/pid /spool/nginx /var/run /run /tmp /etc/uwsgi /etc/nginx && \
    chmod -R g+rwX /var/log /var/cache /run/pid /spool/nginx /var/run /run /tmp /etc/uwsgi /etc/nginx && \
    chown -R nginx:root ${SERVICE_HOME} && \
    chmod -R 777 ${SERVICE_HOME} /etc/passwd

# enter
WORKDIR ${SERVICE_HOME}
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supervisord"]
