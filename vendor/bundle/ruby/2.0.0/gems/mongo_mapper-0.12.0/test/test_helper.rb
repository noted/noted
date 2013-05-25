require 'rubygems'
require 'bundler/setup'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'mongo_mapper'
require 'fileutils'
require 'ostruct'

Bundler.require(:default, :test)

class Test::Unit::TestCase
  def Doc(name='Class', &block)
    klass = Class.new
    klass.class_eval do
      include MongoMapper::Document

      if name
        class_eval "def self.name; '#{name}' end"
        class_eval "def self.to_s; '#{name}' end"
      else
        set_collection_name :test
      end
    end

    klass.class_eval(&block) if block_given?
    klass.collection.remove
    klass
  end

  def EDoc(name='Class', &block)
    klass = Class.new do
      include MongoMapper::EmbeddedDocument

      if name
        class_eval "def self.name; '#{name}' end"
        class_eval "def self.to_s; '#{name}' end"
      end
    end

    klass.class_eval(&block) if block_given?
    klass
  end

  def drop_indexes(klass)
    if klass.database.collection_names.include?(klass.collection.name)
      klass.collection.drop_indexes
    end
  end

  custom_matcher :be_true do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be true but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be true but it was"
    receiver.eql?(true)
  end

  custom_matcher :be_false do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be false but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be false but it was"
    receiver.eql?(false)
  end

  custom_matcher :have_error_on do |receiver, matcher, args|
    receiver.valid?
    attribute = args[0]
    expected_message = args[1]

    if expected_message.nil?
      matcher.positive_failure_message = "#{receiver} had no errors on #{attribute}"
      matcher.negative_failure_message = "#{receiver} had errors on #{attribute} #{receiver.errors.inspect}"
      !receiver.errors[attribute].blank?
    else
      actual = receiver.errors[attribute]
      matcher.positive_failure_message = %Q(Expected error on #{attribute} to be "#{expected_message}" but was "#{actual}")
      matcher.negative_failure_message = %Q(Expected error on #{attribute} not to be "#{expected_message}" but was "#{actual}")
      actual.include? expected_message
    end
  end

  custom_matcher :have_index do |receiver, matcher, args|
    index_name = args[0]
    matcher.positive_failure_message = "#{receiver} does not have index named #{index_name}, but should"
    matcher.negative_failure_message = "#{receiver} does have index named #{index_name}, but should not"
    !receiver.collection.index_information.detect { |index| index[0] == index_name }.nil?
  end
end

log_dir = File.expand_path('../../log', __FILE__)
FileUtils.mkdir_p(log_dir) unless File.exist?(log_dir)
logger = Logger.new(log_dir + '/test.log')

MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 27017, :logger => logger)
MongoMapper.database = "test"
MongoMapper.database.collections.each { |c| c.drop_indexes }
