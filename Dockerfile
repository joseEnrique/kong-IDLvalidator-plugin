FROM kong:latest

COPY kong.conf /etc/kong/

# Copy Plugins to directory where kong expects plugin rocks
COPY ./plugins/ /usr/local/custom/kong/plugins/

# Copy scripts to starting location
COPY ./scripts/ .


ENTRYPOINT [ "./docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]