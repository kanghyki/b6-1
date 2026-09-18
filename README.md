Run

```sh
docker build -t sqlite-practice .
docker run --rm -it -v "$(pwd)/db:/workspace" sqlite-practice my.db
```