class League
  include Mongoid::Document
  field :title, type: String
  field :alias, type: String
  field :type, type: Integer

  validates_uniqueness_of :type
  validates_presence_of :type, :title, :alias
end
