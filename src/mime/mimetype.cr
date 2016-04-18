#TODO: JSON not set
module Mime
  class MimeType
    getter :type
    getter :extensions
    getter :byte_pattern

    def match_pattern?(pattern)

    end

    JSON.mapping({
      type: String,
      extensions: {type: Array(String), default: []},
      byte_pattern: String
    })
  end
end
