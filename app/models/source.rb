require 'citeproc'

class Source
  include Mongoid::Document
  include Mongoid::Timestamps

  field :information, type: Hash
  field :citation,    type: String

  belongs_to :project

  before_save :citation!

  def creatable_by?(u)
    self.project.users.include?(u)
  end

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self.creatable_by?(u)
  end

  def destroyable_by?(u)
    self.creatable_by?(u)
  end

  private

  def citation!
    style = File.open(File.join(Rails.root, 'vendor', 'citation-styles', 'modern-language-association.csl')).read

    self.citation = CiteProc.process(self.information, style: style, format: :html)
  end
end
