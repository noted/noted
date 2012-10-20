class Project
	include MongoMapper::Document

	key :title, String
	key :description, String

	timestamps!
	userstamps!

	belongs_to :user

	many :notes
	many :sources
end