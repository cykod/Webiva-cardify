class CardifyPhoto < DomainModel
  belongs_to :end_user
  has_many :cardify_icon_placements
  

  has_domain_file :image_id
  validates_presence_of :image_id
  
  before_save :generate_permalink


  def generate_permalink
    self.permalink = generate_url(:permalink, self.title.to_s.strip) if self.permalink.blank?
  end
end
