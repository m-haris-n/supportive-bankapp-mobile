#!/bin/bash

# Create temporary directory for the icon
mkdir -p temp_icon

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "ImageMagick is not installed. Please install it first using:"
    echo "  brew install imagemagick   # for macOS"
    echo "  apt-get install imagemagick   # for Ubuntu/Debian"
    exit 1
fi

# Create a base S icon with transparent background (will be used as source)
# This creates a 512x512 black square with white S in the middle
convert -size 512x512 xc:black -fill white -gravity center -pointsize 300 -font Arial-Bold -annotate 0 "S" temp_icon/s_icon_512.png

echo "Created base 512x512 S icon in temp_icon/s_icon_512.png"

# Resize icons for each mipmap directory with appropriate sizes
echo "Resizing icons for Android..."

# mipmap-mdpi: 48x48
convert temp_icon/s_icon_512.png -resize 48x48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png

# mipmap-hdpi: 72x72
convert temp_icon/s_icon_512.png -resize 72x72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png

# mipmap-xhdpi: 96x96
convert temp_icon/s_icon_512.png -resize 96x96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png

# mipmap-xxhdpi: 144x144
convert temp_icon/s_icon_512.png -resize 144x144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png

# mipmap-xxxhdpi: 192x192
convert temp_icon/s_icon_512.png -resize 192x192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

echo "Icon resizing completed!"

echo "Note: For a more professional look, you may want to use Android Studio's Image Asset Studio to create adaptive icons." 