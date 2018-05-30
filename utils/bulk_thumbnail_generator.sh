#!/bin/bash
#
# Generates thumbnails of any image while maintaining the image filetype
#
# 30rd May 2018 Izaskun Mallona
# Inspired by https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/


THUMBNAIL_WIDTH=300
INPUT_PATH=.
OUTPUT_PATH=thumbnail
mkdir -p "$OUTPUT_PATH"

# # To mogrify the whole path
# mogrify -path "$OUTPUT_PATH" -filter Triangle -define filter:support=2 -thumbnail "$THUMBNAIL_WIDTH" \
#         -dither None -posterize 136 -quality 82 \
#         -define png:compression-filter=5 -define jpeg:fancy-upsampling=off  \
#         -define png:compression-level=9 -define png:compression-strategy=1 \
#         -define png:exclude-chunk=all -interlace none -colorspace sRGB \
#         "$INPUT_PATH"

# Does not mogrify the whole directory buth rather processes the files over a given threshold,
#  copying the original version of those below the selected size limit
# Looks for images matching "*jpg" or "*png" filenames

SIZE_THRES=100

mkdir -p thumbnail

for fn in $(find "$INPUT_PATH" -name "*jpg" -or -name "*png")
do
    echo $fn
    filesize=$(ls -l $fn | awk '{print $5}')       
    if [[ "$filesize" -gt "$SIZE_THRES" ]] 
    then 
        name=$(basename "$fn" | cut -f 1 -d '.')

        convert "$fn" -filter Triangle -define filter:support=2 -thumbnail 300 \
                -dither None -posterize 136 -quality 82 \
                -define png:compression-filter=5 -define jpeg:fancy-upsampling=off  \
                -define png:compression-level=9 -define png:compression-strategy=1 \
                -define png:exclude-chunk=all -interlace none -colorspace sRGB \
                "$OUTPUT_PATH"/"$(basename $fn)"

        
    else
        rsync -avt $fn thumbnail/"$(basename $fn)"
    fi
done


