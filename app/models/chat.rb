class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :application_id }

    def self.update_counters
        all.each do |chat|
          chat.update(messages_count: chat.messages.count)
        end
    end

end
