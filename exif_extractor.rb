class ExifExtractor
  attr_reader :exifr
  def initialize(image_path)
    @exifr = exif_info_for(image_path)
  end


  def exif_info_for(image_path)
    case image_path.strip.downcase
    when /\.jpe?g\z/
      EXIFR::JPEG.new(image_path)
    when /\.tiff?\z/
      EXIFR::TIFF.new(image_path)
    else
      raise InvalidImageTypeError
    end
  end

  def latitude
    lat = exifr.gps_latitude.to_f 
    lat == 0? nil : lat
    unless lat == 0
      lat_ref == "S"? -lat : lat
    else
      nil
    end
  end

  def lat_ref
    exifr.gps_latitude_ref
  end

  def longitude
    lon = exifr.gps_longitude.to_f 
    lon == 0? nil : lon
    unless lon == 0
      lon_ref == "W"? -lon : lon
    else
       nil
    end

  end

  def lon_ref
    exifr.gps_longitude_ref
  end

  def altitude
    alt = exifr.gps_altitude.to_f
    alt == 0? nil : alt
  end

  def direction_in_degrees
    exifr.gps_img_direction.to_f.round 2
  end

  def direction
    case
    when direction_in_degrees < 22.5 || direction_in_degrees >= 337.5
      "N"
    when direction_in_degrees < 67.5
      "NE"
    when direction_in_degrees < 112.5
      "E"
    when direction_in_degrees < 157.5
      "SE"
    when direction_in_degrees < 202.5
      "S"
    when direction_in_degrees < 247.5
      "SW"
    when direction_in_degrees < 292.5
      "W"
    when direction_in_degrees < 337.5
      "NW"
    end
  end

  def width
    exifr.width || exifr.pixel_x_dimension
  end  

  def height
    exifr.height || exifr.pixel_y_dimension
  end

  def make
    exifr.make
  end

  def model
    exifr.model
  end

  def resolution
    exifr.x_resolution.to_i
  end

  def date_time_taken
    exifr.date_time_original
  end

  def shutter_speed
    time = exifr.shutter_speed_value || exifr.exposure_time
    time.to_s
  end

  def brightness
    exifr.brightness_value.to_f
  end

  def f_stop
    exifr.f_number.to_f || exifr.aperture_value.to_f
  end

  def iso
    exifr.iso_speed_ratings
  end


  def metering_mode
    exifr.metering_mode
  end

  def flash
    exifr.flash
  end

  def focal_length
    exifr.focal_length.to_i
  end

  def color_space
    exifr.color_space
  end

  def non_exif_methods
    [:exifr_hash, :exifr, :exif_info_for, :extraction_methods, :non_exif_methods,
     :lat_ref, :lon_ref, :orientation]
  end

  def extraction_methods
    all_methods = self.class.instance_methods(false)
    all_methods.select { |m| m.to_s unless non_exif_methods.include? m }
  end

  def exifr_hash
    ex_hash = {}
    extraction_methods.each do |m|
      ex_hash[m] = self.send(m)
    end
    ex_hash
  end

end

class InvalidImageTypeError < ArgumentError
  def to_s
    "Only 'jpegs' and 'tiffs' accepted"
  end
end
