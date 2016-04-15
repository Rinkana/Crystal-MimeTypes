module Mime
  class MimeType
    getter :type
    getter :extensions
    getter :byte_pattern

    JSON.mapping({
      type: String,
      extensions: Array(String),
      byte_pattern: String
    })
  end
end
