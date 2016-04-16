# mime

This is an mime type lib for Crystal.
This library not only uses the extension but when given a file object it will also try to detect the mime type based on the leading bytes.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  mime:
    github: Rinkana/Crystal-MimeTypes
```


## Usage


```crystal
require "mime"

#Get a mime type from a file. Will return Mime::MimeType if found. Nil if not.
mime_type = Mime.from_file(File.open(File.join(__DIR__, "test.jpg")))

#Get a mime type from an extension only. Please note that the leading dot needs to be absent.
mime_type = Mime.from_extension("jpg")
```


## Contributing

1. Fork it ( https://github.com/Rinkana/Crystal-MimeTypes/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Rinkana](https://github.com/Rinkana)  - creator, maintainer
