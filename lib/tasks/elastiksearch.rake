namespace :elasticsearch do
  desc 'Create Elasticsearch index for Message'
  task create_index: :environment do
    Message.__elasticsearch__.create_index!(force: true)
    Message.import
  end
end
