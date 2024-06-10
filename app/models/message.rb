class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  validates :number, presence: true, uniqueness: { scope: :chat_id }

# This for __elasticsearch__
      settings do
          mappings dynamic: false do
            indexes :body, type: :text
          end
        end

        def self.search(query)
          response = __elasticsearch__.search(
            {
              query: {
                multi_match: {
                  query: query,
                  fields: ['body']
                }
              }
            }
          )
          response.records
        end

#this for normal search
#     def self.search(query)
#         where("body LIKE ?", "%#{query}%")
#     end
 end
