Elasticsearch::Model.client = Elasticsearch::Client.new(host: 'localhost', log: true)

Message.__elasticsearch__.create_index!
Message.import
