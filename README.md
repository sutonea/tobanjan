# Tobanjan

配列からランダムに要素を抽出する際に、制限を設けられるようにします。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tobanjan'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tobanjan

## Usage

**example.rb**

```ruby
require 'bundler'
Bundler.require
require 'tobanjan'

candidates = ::Tobanjan::CandidateList.create ["A", "B", "C"]
list_choiced = []
6.times do
  list_choiced << candidates.choice!
end
puts list_choiced.sort.join
```

```bash
$ ruby example.rb
AABBCC
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sutonea/tobanjan.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

