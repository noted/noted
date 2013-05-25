require 'json'
class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

class CIJoe
  class Build < Struct.new(:project_path, :user, :project, :started_at, :finished_at, :sha, :status, :output, :pid, :branch)

    def initialize(*args)
      super
      self.started_at ||= Time.now
    end

    def self.new_from_hash(hash)
      hash.symbolize_keys!
      members = Build.members.map{|member| member.to_sym}

      (hash.keys - members).tap do |extra_arguments|
        if extra_arguments.any?
          raise ArgumentError.new("invalid argument #{extra_arguments.join(' ')}")
        end
      end

      new( *hash.values_at(*members))
    end

    def status
      return super if started_at && finished_at
      :building
    end

    def failed?
      status == :failed
    end

    def worked?
      status == :worked
    end

    def building?
      status == :building
    end

    def duration
      return if building?
      finished_at - started_at
    end

    def short_sha
      if sha
        sha[0,7]
      else
        "<unknown>"
      end
    end

    def to_map
      map = Hash.new
      self.members.each { |m| map[m] = self[m] }
      map
    end

    def to_json(*a)
      to_map.tap do |hash|
        hash[:started_at] = hash[:started_at].strftime('%Y-%m-%d %H:%M:%S %z') if hash[:started_at]
        hash[:finished_at] = hash[:finished_at].strftime('%Y-%m-%d %H:%M:%S %z') if hash[:finished_at]
      end.to_json(*a)
    end

    def clean_output
      output.gsub(/\e\[.+?m/, '').strip
    end

    def env_output
      out = clean_output
      out.size > 100_000 ? out[-100_000,100_000] : out
    end

    def commit
      return if sha.nil?
      @commit ||= Commit.new(sha, user, project, project_path)
    end

    def dump
      JSON.pretty_generate self
    end

    def self.parse(data, project_path)
      config = JSON.load(data)
      new_from_hash(config).tap do |build|
        build.project_path = project_path
        build.started_at = Time.parse(build.started_at).utc if build.started_at
        build.finished_at = Time.parse(build.finished_at).utc if build.finished_at
      end
    end
  end
end
