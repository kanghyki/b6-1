Docker build for SQLite and Run

```sh
docker build -t sqlite-practice .
docker run --rm -it -v "$(pwd)/db:/workspace" sqlite-practice my.db
```

Make schema and check

```sh
docker run --rm -i -v "$(pwd)/db:/workspace" sqlite-practice my.db < sql/schema.sql

docker run --rm -i -v "$(pwd)/db:/workspace" sqlite-practice my.db < sql/check.sql
```

Insert data and check

```sh
docker run --rm -i -v "$(pwd)/db:/workspace" sqlite-practice my.db < sql/insert.sql

docker run --rm -i -v "$(pwd)/db:/workspace" sqlite-practice my.db < sql/check.sql
```

Query

```sh
docker run --rm -i -v "$(pwd)/db:/workspace" sqlite-practice my.db < sql/queries.sql
```