require "rubygems"
require "chef/handler"

class ChefMetrics < Chef::Handler
  attr_accessor :metric_scheme, :measure_time, :metrics, :use_run_state, :action

  def initialize(&action)
    @metric_scheme = "chef.#{Chef::Config.node_name}"
    @measure_time = Time.now.to_i
    @metrics = Hash.new
    @use_run_state = true
    @action = action
  end

  def run_state_metrics!
    if node.run_state[:metrics].is_a?(Hash)
      @metrics.merge!(node.run_state[:metrics])
    end
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
    if @use_run_state
      run_state_metrics!
    end
    if @action
      self.instance_eval(&@action)
    else
      Chef::Log.info("Chef Metrics report handler was not provided an action")
    end
  end
end
