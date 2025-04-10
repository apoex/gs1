# GS1

GS1 provides the tools to make your code GS1 compliant.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gs1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gs1

## Usage

Follow the examples below to start using the gem.

### Configuration

There are some configuration you can do before start using this lib.

```ruby
GS1.configure do |config|
  config.company_prefix = '123456789'
  config.barcode_separator = '~' # Default is "\u001E"
  config.ignore_extra_barcode_elements = false # Default is true
end
```

### Application identifiers

To access the defined application identifier:

```ruby
GS1::AI::GTIN # => "01"
```

or via the class:

```ruby
GS1::ExpirationDate::AI # => "17"
GS1::ExpirationDate.ai # => "17"
```

To get the class from a numeric id:

```ruby
GS1::AI_CLASSES[GS1::AI::BATCH_LOT] # => "GS1::Batch"
```

### Healthcare barcodes

To initialize a healthcare barcode from scan input:

```ruby
GS1::Barcode::Healthcare.from_scan("01034531200000111719112510ABCD1234\u001E2110")
# => #<GS1::Barcode::Healthcare:0x007fe1b99ea280
#      @gtin=#<GS1::GTIN:0x007fe1b99e9a10 @errors=[], @data="03453120000011">,
#      @expiration_date=#<GS1::ExpirationDate:0x007fe1b99e8700 @errors=[], @data="191125">,
#      @batch=#<GS1::Batch:0x007fe1b99e3b10 @errors=[], @data="ABCD1234">,
#      @serial_number=#<GS1::SerialNumber:0x007fe1b99e2670 @errors=[], @data="10">,
#      @errors=[]>
```

or just get the attributes

```ruby
GS1::Barcode::Healthcare.from_scan("01034531200000111719112510ABCD1234\u001E2110")
# => {:gtin=>"03453120000011", :expiration_date=>"191125", :batch=>"ABCD1234", :serial_number=>"10"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/apoex/gs1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gs1 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/apoex/gs1/blob/master/CODE_OF_CONDUCT.md).
