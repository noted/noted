require 'citeproc'

class Source
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable
  include PublicActivity::Model

  field :information, type: Hash
  field :citation,    type: String

  belongs_to :project

  before_save :citation!

  tracked

  track_history on: [:information, :citation],
                modifier_field: :updater,
                version_field: :version,
                track_create: true,
                track_update: true,
                track_destroy: true

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
    style = File.open(File.join(Rails.root, 'vendor', 'citation-styles', "#{self.project.citation_style}.csl")).read

    self.citation = CiteProc.process(self.information, style: style, format: :html)
  end
end
