class Link < ApplicationRecord
    validates :original_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
    validates :short_url, presence: true, uniqueness: true
end
  