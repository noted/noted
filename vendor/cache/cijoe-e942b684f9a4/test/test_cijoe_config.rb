require 'helper'

describe 'CIJoe::Config' do

  it 'raises error on invalid command' do
    lambda { CIJoe::Config.new('--invalid').to_s}.must_raise(RuntimeError, LoadError)
  end

  it 'returns a config value' do
    CIJoe::Config.new('core.editor').to_s.must_equal `git config core.editor`.chomp
  end

  it 'returns empty string when config key does not exist' do
    CIJoe::Config.new('cijoe.invalid').to_s.must_be_empty
  end

  it 'returns empty string when config section does not exist' do
    CIJoe::Config.new('invalid').to_s.must_be_empty
  end
end
