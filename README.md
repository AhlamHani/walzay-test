# README

```shell
# Some prerequisites to run locally
brew install libpq
brew install postgresql-client

gem pristine racc --version 1.7.3
gem pristine nokogiri --version 1.15.3
gem pristine nokogiri --version 1.15.2
gem pristine nokogiri --version 1.13.1

# Or run the docker compose stack
docker compose up
```

| Service         | URL                   |
|-----------------|-----------------------|
| Web             | http://localhost:3000 |
| Redis-commander | http://localhost:8081 |
| Dejavu          | http://localhost:1358 |