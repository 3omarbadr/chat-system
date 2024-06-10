class Application < ApplicationRecord
  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

    def self.update_counters
        all.each do |application|
          application.update(chats_count: application.chats.count)
        end
    end

  private

  def generate_token
        self.token ||= SecureRandom.uuid
  end
end
