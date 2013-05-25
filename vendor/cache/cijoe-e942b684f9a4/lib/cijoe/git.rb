class CIJoe
  class Git
    attr_reader :project_path

    class InvalidGitRepo < StandardError
      def to_s
        'Invalid git repo path.'
      end
    end

    def initialize(project_path)
      @project_path = project_path
    end

    def branch_sha(branch)
      `cd #{@project_path} && git rev-parse origin/#{branch}`.chomp
    end

    def update
      `cd #{@project_path} && git fetch origin && git reset --hard origin/#{branch}`
    end

    def tag(sha, name)
      `cd #{@project_path} && git tag -f #{name} #{sha}`
    end

    def rev_parse(name)
      result = `cd #{@project_path} && git rev-parse #{name} 2>/dev/null`.chomp
      $? == 0 ? result : nil
    end
    alias :tag_sha :rev_parse

    # use a tmp file to add the note
    # to go around bash quoting nightmare
    # TODO: maybe use pipes to do this in memory
    def note(sha, text)
      begin
        file = Tempfile.new('cijoe_note')
        file.write(text)
        file.close
        `cd #{@project_path} && git notes --ref=build add -F #{file.path} -f 2>/dev/null #{sha}`
        exit_status = $?
      ensure
        file.close!
      end

      exit_status == 0 ? true : false
    end

    def note_message(sha)
      `cd #{@project_path} && git notes --ref=build show #{sha}`.chomp
    end

    def user_and_project
      url = git_remote_url
      unless url.empty?
        url.chomp('.git').split(':')[-1].split('/')[-2, 2]
      else
        nil
      end
    end

    def branch
      branch = Config.cijoe(@project_path).branch.to_s
      if branch.empty?
        'master'
      else
        branch
      end
    end

    private
    def git_remote_url
      Config.remote(@project_path).origin.url.to_s
    end
  end
end
