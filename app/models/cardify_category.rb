class CardifyCategory < DomainModel
  has_many :themes
  has_many :icons

  validates_presence_of :name
  # Description is optional
end

