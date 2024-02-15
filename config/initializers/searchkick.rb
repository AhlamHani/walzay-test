Searchkick.client = Elasticsearch::Client.new(
  hosts:             [ENV.fetch('ELASTICSEARCH_URL') { 'http://localhost:9200' }],
  retry_on_failure:  true,
  transport_options: {
    request: {
      timeout: 250
    }
  }
)