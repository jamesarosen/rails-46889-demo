See https://github.com/rails/rails/issues/46889

Start containers for development:
```
docker compose up -d
```

With those containers running, get a Unix shell in the container that has Rails:
```
docker compose exec app sh
```

or a Rails shell:
```
docker compose exec app rails c
```

or a Postgresql shell:
```
docker compose exec db psql -U postgres -d rails_change_table_development
```
