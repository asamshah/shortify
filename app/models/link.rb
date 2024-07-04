class Link < ApplicationRecord
    validates :original_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
    validates :short_url, presence: true, uniqueness: true
  
    before_create :generate_short_url
  
    private
  
    def generate_short_url
      loop do
        self.short_url = "#{random_emoji}#{SecureRandom.alphanumeric(6)}"
        break unless Link.exists?(short_url: short_url)
      end
    end
  
    def random_emoji
      EMOJIS.sample
    end
  end