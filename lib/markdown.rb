require 'redcarpet'

class Markdown
  attr_reader :markdown, :html

  def self.to_mongo(value)
    value.to_s
  end

  def self.from_mongo(value)
    value.is_a?(Markdown) ? value : Markdown.new(value)
  end

  def initialize(str)
    rc = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      :autolink => true,
      :space_after_headers => true
    )

    @markdown = str
    @html = rc.render(@markdown)
  end

  def to_s
    @markdown
  end
end
