module Mime
  class BytePattern

    property :pattern
    getter :mask

    TAG_TERMINATING_BYTES = ["20", "3E"]

    def matches?(header)
      #return pattern.starts_with?(@pattern)
      return false if header.empty?

      pattern_data = @pattern.split(" ").zip?(@mask.to_s.split(" ").reject { |e| e.empty? })

      matches = true

      header.split(" ").reject { |e| e.empty? }.zip?(pattern_data) do |byte, data|

        break if data.nil?

        pattern_byte = data[0]
        pattern_mask_byte = data[1]

        if pattern_byte == "TT"
          #Test test if the given byte is a tag terminating byte
          matches = false if !TAG_TERMINATING_BYTES.includes?(byte)
        else
          pattern_byte = pattern_byte.to_u8(16)
          byte = byte.to_u16(16)

          #What to check do based on the mask
          case pattern_mask_byte
          when "FF", nil
            #Needs to be exact match
            matches = false if byte != pattern_byte
          when "DF"
            #Can be upper or lower
            matches = false if byte != pattern_byte && byte != ( 'A' <= pattern_byte.chr <= 'Z' ? pattern_byte + 32 : pattern_byte - 32 )
          when "00"
            #Does not matter, skip
            next
          else
            #No pattern mask given, skip
            #TODO: throw error
            #matches = false
            next
          end
        end
      end

      matches
    end

    JSON.mapping({
      pattern: String,
      mask: {type: String, nilable: true}
    });

  end
end
