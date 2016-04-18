#TODO: JSON not set
module Mime
  class MimeType
    getter :type
    getter :extensions
    getter :byte_patterns

    def match_pattern?(pattern)
      @byte_patterns.each do |valid_pattern|
        return true if pattern.starts_with?(valid_pattern)
      end

      return false
    end

    def biggest_pattern
      @byte_patterns.max_by { |pattern| pattern.size }
    end

    def smallest_pattern
      @byte_patterns.min_by { |pattern| pattern.size }
    end

    JSON.mapping({
      type: String,
      extensions: {type: Array(String), default: [] of String},
      byte_patterns: {type: Array(String), default: [] of String}
    })
  end
end
