require 'rspec/core/formatters/base_text_formatter'
require 'ruby-progressbar'
require 'rspec/instafail'

class Fuubar < RSpec::Core::Formatters::BaseTextFormatter

  def start(example_count)
    super
    @progress_bar   = ProgressBar.create(:format => ' %c/%C |%w>%i| %e ', :total => example_count, :output => output)
  end

  def increment
    with_color do
      @progress_bar.increment
    end
  end

  def example_passed(example)
    super
    increment
  end

  def example_pending(example)
    super
    @state = :yellow unless @state == :red
    increment
  end

  def example_failed(example)
    super
    @state = :red

    output.print "\e[K"
    instafail.example_failed(example)
    output.puts

    increment
  end

  def dump_failures
    # don't!
  end

  def instafail
    @instafail ||= RSpec::Instafail.new(output)
  end

  def with_color
    output.print "\e[#{colors[state]}m" if color_enabled?
    yield
    output.print "\e[0m"
  end

  def state
    @state ||= :green
  end

  def colors
    { :red => 31, :green => 32, :yellow => 33 }
  end

end
