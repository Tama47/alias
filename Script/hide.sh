cd /Volumes/media/Anime && \
find . \( -name "*.ass" -o -name "*.srt" -o -name "*.txt" -o -name "*.mp3" -o -name "*.jpe" -o -name "*.jpeg" \) \
-exec chflags hidden {} + && \
find /Volumes/media/Anime -type f -iname "thumbs.db" -print -exec rm -f {} \;