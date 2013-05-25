require 'rubygems'
require 'minitest/autorun'
require 'mocha/setup'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'cijoe'

CIJoe::Server.set :project_path, "."
CIJoe::Server.set :environment,  "test"


TEST_DIR = File.dirname(File.expand_path(__FILE__))
TMP_DIR = File.join(TEST_DIR, 'temp')
FileUtils.mkdir_p(TMP_DIR)

class MiniTest::Unit::TestCase
  private

  def setup_test_repo
    dir = Dir.mktmpdir('dir', TMP_DIR)
    repo_dir = File.join(TEST_DIR, (File.join('fixtures', 'testrepo.git', '.')))
    `git clone #{repo_dir} #{dir}`
    dir
  end

  def destroy_repo(repo)
    FileUtils.remove_entry_secure repo
  end

end
