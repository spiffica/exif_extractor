class ExifInfo < ActiveRecord::Base
  belongs_to :photo
  attr_accessible :altitude, :height, :latitude, :longitude, :width, :direction,
  	:direction_in_degrees, :resolution, :make, :model, :date_time_taken, :shutter_speed, :brightness,
  	:f_stop, :iso, :metering_mode, :flash, :focal_length, :color_space, :orientation
end
