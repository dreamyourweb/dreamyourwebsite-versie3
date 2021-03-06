class Associate < ActiveRecord::Base
	has_many :posts
	attr_accessible :name, :avatar, :job_title, :uvp, :biography, :description, :name_for_url, :active
	validates_presence_of :name
	mount_uploader :avatar, HeadshotUploader
	before_save :build_url
	
	def build_url
		self.name_for_url = self.name.to_url
	end

	def to_param
		self.name_for_url
	end
end
