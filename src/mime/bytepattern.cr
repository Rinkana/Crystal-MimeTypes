module Mime
  class BytePattern

    property :pattern
    getter :mask

    def matches?(pattern)
      return pattern.starts_with?(@pattern)
    end

    JSON.mapping({
      pattern: String,
      mask: {type: String, nilable: true}
    });

  end
end
