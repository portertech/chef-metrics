require "rubygems"
require "chef/handler"

class ChefMetrics < Chef::Handler
  attr_accessor :action, :metric_scheme, :measure_time, :metrics

  def initialize(&action)
    @action = action
    @metric_scheme = "chef"
    @measure_time = Time.now.to_i
    @metrics = Hash.new
  end

  def graphite_formatted
    @metrics.inject("") do |result, (metric, value)|
      result << "#{@metric_scheme}.#{metric} #{value} #{@measure_time}\n"
      result
    end
  end

  def report
    @measure_time = Time.now.to_i
    @metrics[:updated_resources] = run_status.updated_resources.length
    @metrics[:all_resources] = run_status.all_resources.length
    @metrics[:elapsed_time] = run_status.elapsed_time
    if run_status.success?
      @metrics[:success] = 1
      @metrics[:fail] = 0
    else
      @metrics[:success] = 0
      @metrics[:fail] = 1
    end
    if @action
      @action.call
    else
      Chef::Log.info("Chef Metrics report handler was not provided an action")
    end
  end
end
