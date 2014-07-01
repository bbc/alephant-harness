# Alephant::Harness

Provides supporting classes for running the alephant framework locally.

Alephant::Harness::Setup.configure tears down and sets up the Alephant framework's AWS resources.

## Installation

Add this line to your application's Gemfile:

    gem 'alephant-harness'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alephant-harness

## Usage

Add the following code to your Alephant-based project's Rakefile, with your own configuration:

```ruby
require 'alephant/harness'

config = { :sqs_queue_url        => 'your-sqs-queue-url',
           :bucket_id            => 'your-bucket-id',
           :lookup_table_name    => 'your-lookup-table-name',
           :sequencer_table_name => 'your-sequencer-table-name' }

task :harness do
  Alephant::Harness::Setup.configure(config, ENV)
end
```

## Contributing

1. Fork it ( https://github.com/bbc-news/alephant-harness/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
