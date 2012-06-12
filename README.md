# Chef Metrics


TODO: Write a gem description

## Installation

TODO: Write installation instructions here

## Usage

Append the following to your Chef client configs, usually at =/etc/chef/client.rb=

    require "chef-metrics"

    metric_handler = ChefMetrics.new do
      # see examples below
    end

    report_handlers << metric_handler
    exception_handlers << metric_handler

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
