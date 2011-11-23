class CardifyIconPlacement < DomainModel
  belongs_to :cardify_photo
  belongs_to :cardify_icon

  validates_presence_of :x
  validates_presence_of :y
end
