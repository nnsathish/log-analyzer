# LogAnalyzer

Simple webserver log parser and analyzer to return basic insights like
no.of.views and no.of.unique views

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_analyzer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_analyzer

## Usage

```
LogAnalyzer.run(<fpath>)
```
`fpath` being the path of the log file

Also includes a command-line script, from gem-root, run:
```
./bin/log_analyzer <fpath>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nnsathish/log_analyzer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
