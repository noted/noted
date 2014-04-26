class CitationStyle
  include Mongoid::Document

  field :shortname, type: String
  field :title,     type: String

  validates :shortname, presence: true
  validates :title, presence: true

  before_validation :save_information!

  def csl
    CSL::Style.load(self.shortname)
  end

  class << self
    def options
      styles_hash = {}
      self.all.order('title asc').each do |style|
        unless style.title.nil?
          styles_hash[style.shortname] = style.title
        end
      end

      styles_hash
    end

    def html_options(selected = nil)
      # Use Rails because it preloads the style options.
      styles = Rails.configuration.style_options
      options = ''

      styles.each do |shortname, title|
        if shortname == selected
          options << "<option selected='selected' value='#{shortname}'>#{title}</option>"
        else
          options << "<option value='#{shortname}'>#{title}</option>"
        end
      end

      return options
    end

    def seed!
      CSL::Style.ls.each do |shortname|
        existing = CitationStyle.where(shortname: shortname).first

        if existing.nil?
          style = CitationStyle.new(
            shortname: shortname
          )

          style.save
        end
      end
    end
  end

  private

  def save_information!
    if !csl.nil? && csl.has_info?
      self.title = self.csl.info.title
    end
  end
end
