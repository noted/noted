class Markdown
  attr_reader :markdown, :html

  def self.to_mongo(value)
    value.to_s
  end

  def self.from_mongo(value)
    value.is_a?(self) ? value : Markdown.new(value.to_s)
  end

  def initialize(str)
    @markdown = str.to_s
    @html = Maruku.new(@markdown).to_html
  end

  def to_s
    @markdown
  end
end