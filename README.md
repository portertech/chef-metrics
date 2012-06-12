# Chef Metrics

Chef Metrics is an OpsCode Chef report/exception handler for sending
Chef metrics to one or more endpoints. Metrics are gathered using
`run_status` and `node.run_state[:metrics]` (optional). The method of
metric delivery to the endpoint/s of choice is left up to the
user. You can't manage what you don't measure.

## Installation

    gem install chef-metrics

## Usage

Append the following to your Chef client configs, usually at `/etc/chef/client.rb`

    require "chef-metrics"

    metric_handler = ChefMetrics.new do
      # see examples below
    end

    report_handlers << metric_handler
    exception_handlers << metric_handler

## Examples

The following examples are "action" blocks:

    metric_handler = ChefMetrics.new do
      # action block
    end

Note: I recommend adding logging, timeouts, and error handling to the following.

### Graphite

    require 'socket'

    socket = TCPSocket.new(GRAPHITE_HOST, GRAPHITE_PORT)
    socket.write(graphite_formatted)
    socket.close

### Sensu

    require 'socket'

    sensu_result = {
      :name => "chef_report",
      :type => "metric",
      :handler => "metrics",
      :output => graphite_formatted
    }

    socket = TCPSocket.open('127.0.0.1', 3030)
    socket.write(sensu_result.to_json)
    socket.close

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
