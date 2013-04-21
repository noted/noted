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

    if @markdown
      @html = rc.render(@markdown)
    else
      @html = ""
    end
  end

  def to_s
    @markdown
  end
end
