FROM migrate/migrate:v4.15.2

COPY . .

ENTRYPOINT ["/run.sh"]