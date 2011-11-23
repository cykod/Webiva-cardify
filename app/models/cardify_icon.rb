class CardifyIcon < DomainModel
  has_many :icon_placements
  belongs_to :category

  has_domain_file :image_id
  
  validates_presence_of :image_id
end
