require "helper"

describe CIJoe::Git do
  def setup
    @path = setup_test_repo
    @git = CIJoe::Git.new(@path)
  end

  def teardown
   destroy_repo(@path)
  end

  describe '#user_and_project' do
    it 'returns an array of current github user and project' do
      @git.stub :git_remote_url, 'git@github.com:user/repo.git' do
        @git.user_and_project.must_equal ['user','repo']
      end
    end

    it 'returns nil on invalid project dir' do
      git = CIJoe::Git.new('invalid_repo_path')
      git.user_and_project.must_be_nil
    end
  end

  describe '#branch_sha' do
    it 'returns the correct HEAD sha of a branch' do
      @git.branch_sha('master').must_equal 'b557b867cfc8b86aa5ad73729ffe0017922fbce1'
    end
  end

  describe '#branch' do
    it 'returns the correc branch ref name' do
      @git.branch.must_equal 'master'
    end
  end

  describe '#tag' do
    it 'creates a tag' do
      sha = '018141ee284c47db643e5fd6da9e639f32f891ef'
      tag_name = 'current'
      @git.tag(sha, tag_name)
      tag_sha = `cd #{@git.project_path} && git rev-parse #{tag_name}`.chomp

      tag_sha.must_equal sha
    end

    it 'overwrites existing tags' do
      tag_name = 'current'
      @git.tag('HEAD~1', tag_name)
      @git.tag('HEAD', tag_name)

      @git.tag_sha(tag_name).must_equal @git.rev_parse('HEAD')
    end

    it 'returns nil on nonexisting tag sha' do
      tag_name = 'current'
      @git.tag_sha(tag_name).must_be_nil
    end
  end

  describe '#note' do
    it 'can add a note' do
      text = 'note\' test'
      sha = 'HEAD'
      @git.note(sha, text)
      note_text = `cd #{@git.project_path} && git notes --ref=build show HEAD`

      note_text.must_equal text + "\n"
    end

    it 'overwrites object notes' do
      text = 'note test'
      sha = 'HEAD'
      @git.note(sha, text)

      @git.note(sha, text).must_equal true
    end
  end

  describe '#note_message' do
    it 'returns notes body' do
      text = 'note test'
      sha = 'HEAD'
      @git.note(sha, text)

      @git.note_message(sha).must_equal text
    end
  end

  describe '#update' do
    it 'updates the current HEAD' do
      @git.update.must_include 'HEAD is now at'
    end
  end
end
