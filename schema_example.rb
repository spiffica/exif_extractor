create_table "exif_infos", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.integer  "width"
    t.integer  "height"
    t.integer  "photo_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "resolution"
    t.string   "make"
    t.string   "model"
    t.datetime "date_time_taken"
    t.string   "shutter_speed"
    t.float    "brightness"
    t.float    "f_stop"
    t.integer  "iso"
    t.integer  "metering_mode"
    t.integer  "flash"
    t.integer  "focal_length"
    t.integer  "color_space"
    t.string   "direction"
    t.float    "direction_in_degrees"
  end