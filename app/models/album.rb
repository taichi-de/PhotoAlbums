class Album < ApplicationRecord
  has_many_attached :images
  validates :title, presence: true
  validates :discription, presence: true
  validate :image_type

  def thumbnail input
    return self.images[input].variant(resize: '400x300!').processed
  end

  private
  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'needs to be a JPEG or PNG!')
      end
    end
  end
end
