# frozen_string_literal: true

require 'singleton'

# Protection for access_tokens
class TokenMap
  include Singleton

  def initialize
    @tokens = {}
  end

  def set(access_token)
    token = SecureRandom.hex 8
    @tokens[token] = access_token
    token
  end

  def get(token)
    @tokens[token]
  end
end
