require 'citeproc'

class Source
  include Mongoid::Document
  include Mongoid::Timestamps

  field :information, type: Hash
  field :citation,    type: String

  belongs_to :project

  before_save :citation!

  private

  def citation!
    style = File.open(File.join(Rails.root, 'vendor', 'citation-styles', 'modern-language-association.csl')).read

    self.citation = CiteProc.process(self.information, style: style, format: :html)
  end
end
