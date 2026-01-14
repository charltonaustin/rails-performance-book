# README

Update the memory to have 12 Gigs
Update the cpu to be 4
Make sure to not have anything else running on the same ports.
To start everything up simply run

```shell
docker-compose up
```

# Important Notes

The seeds.rb has been updated to make inserting of the stores significantly faster.


By default, the datadog configuration won't work and needs to be updated with an API key.

To log into the rails_web container in order to have access to the ruby repl

```shell
docker exec -it rails_web /bin/bash
```