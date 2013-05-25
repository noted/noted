class CIJoe
  class Config

    def git_config_error_codes
      [1,2,255]
    end
    def self.method_missing(command, *args)
      new(command, *args)
    end

    def initialize(command, project_path = nil, parent = nil)
      @command  = command
      @parent   = parent
      @project_path = project_path || File.join(File.dirname(__FILE__), '../../')
    end

    def method_missing(command, *args)
      Config.new(command, @project_path, self)
    end

    def to_s
      git_command = "cd #{@project_path} 2>/dev/null && git config #{config_string}"
      result = `#{git_command} 2>/dev/null`.chomp

      process_status = $?

      if successful_command?(process_status) || config_command_with_empty_value?(result,process_status)
        return result
      else
        raise "Error calling git config, is a recent version of git installed? Command: #{git_command.inspect}, Error: #{result.inspect}, Status: #{process_status.inspect}"
      end
    end

    def config_string
      @parent ? "#{@parent.config_string}.#{@command}" : @command
    end

    private

    def successful_command?(process_status)
      process_status.exitstatus.to_i == 0
    end

    def config_command_with_empty_value?(result, process_status)
      git_config_error_codes.include?(process_status.exitstatus.to_i) && result.empty?
    end
  end
end
