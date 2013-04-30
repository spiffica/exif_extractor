# ExifExtractor
***
I have extracted files from a small project of mine. I needed a simple way to take a photo and input its attributes into the database.  

I started with the Ruby Exif Reading Library 'EXIFR'.

My main interest was getting the geo info and setting its direction in a string ie. "N","SE", etc. I wanted all the attributes to be in a suitable format without having to remember to call 'to_f' or 'to_i' again and again in the future.

The final result, with a call to *exifr_hash*, will output a hash with all attributes ready for the database.



I plan on configuring this into a gem. Hopefully it will be completed soon.

Any help or recommendations are welcome.