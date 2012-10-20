class Institution
	include MongoMapper::Document

	key :name, String

	timestamps!
	userstamps!

	many :users
end