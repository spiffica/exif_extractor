class Photo < ActiveRecord::Base
  attr_accessible :photoable_id, :photoable_type, :title, :image,
  		 :remote_image_url
  belongs_to :photoable, :polymorphic => true
  has_one :exif_info, dependent: :destroy
  validates :image, presence: true

  mount_uploader :image, PhotoUploader


  def extracted_exif_hash
    begin
  	  ExifExtractor.new(image.path).exifr_hash
    rescue InvalidImageTypeError
      nil
    end
  end

  def gps?
    self.exif_info.latitude != nil
  end

end
