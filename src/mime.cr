require "json"
require "./mime/*"

module Mime

  @@header_size = 0 #How many bytes are needed to try all byte_patterns

  #Get the mime tipe from a `file`
  def self.from_file(file)
    #Preload the file header for easier matching
    file_header = "";
    1.upto(@@header_size) do
      header_byte = file.read_byte
      if !header_byte.nil?
        file_header += sprintf("%02X", file.read_byte) + " "
      end
    end

    #Try to find a type based on the byte_pattern
    result = index.select {|mime_type| !mime_type.byte_pattern.empty? && file_header.starts_with? mime_type.byte_pattern}
    if result.size == 1 #single result found, return
      return result.first
    end

    file_extension = File.extname(file.path)[1..-1] #Get the extension and remove the dot
    if result.size >= 1
      #TODO: what do when this yields no results
      return result.select {|mime_type| mime_type.extensions.includes? file_extension}.first?
    else
      return from_extension(file_extension)
    end

    nil
  end

  #Get the mime type from an extension
  #This does not allow extensions with dots or full paths
  #TODO allow dots and full paths
  def self.from_extension(extension)
    return index.select {|mime_type| mime_type.extensions.includes? extension}.first?
  end

  #Get the mimetype index
  #
  #TODO: Is it a good idea to cache this?
  #Is there a middle road availible?
  def self.index
    @@mime_types ||= begin
      type_defs = File.read(File.join(__DIR__, "mime/types.json"))
      mime_types = [] of MimeType
      JSON.parse(type_defs).each do |typedef|
        mime_type = MimeType.from_json(typedef.to_json)
        header_size = mime_type.byte_pattern.delete(' ').size / 2

        @@header_size = @@header_size > header_size ? @@header_size : header_size

        mime_types << mime_type
      end
      mime_types
    end
  end
end
