#docker-elasticsearch

Start this with:

`docker run -d -p 9200:9200 -p 9300:9300 rossbachp/elasticsearch`

*data/elasticsearch.yml*
```yaml
path:
  logs: /data/log
  data: /data/data
```

`docker run -d -p 9200:9200 -p 9300:9300 -v <data-dir>:/data rossbachp/elasticsearch /usr/local/bin/elasticsearch -Des.config=/data/elasticsearch.yml`

```bash
    $ curl localhost:9200
{
  "status" : 200,
  "name" : "Scorcher",
  "version" : {
    "number" : "1.3.2",
    "build_hash" : "dee175dbe2f254f3f26992f5d7591939aaefd12f",
    "build_timestamp" : "2014-08-13T14:29:30Z",
    "build_snapshot" : false,
    "lucene_version" : "4.9"
  },
  "tagline" : "You Know, for Search"
}
```
