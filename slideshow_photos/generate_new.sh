cat << 'EOF' > generate.sh
#!/bin/bash
cat << 'HTML' > slideshow.html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  body { margin: 0; background: #e8e1e1; color: #111; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; overflow: hidden; }
  .slide { display: none; text-align: center; position: relative; width: 100%; height: 100%; }
  .active { display: flex; flex-direction: column; justify-content: center; align-items: center; }
  
  /* Photo Slide Styling */
  img { max-width: 90vw; max-height: 80vh; object-fit: contain; border: 3px solid #d4af37; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); }
  .caption { margin-top: 15px; font-size: 1.8rem; color: #111; background: rgba(255, 255, 255, 0.85); padding: 10px 20px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
  
  /* Decade Title Slide Styling (Grey background with black text) */
  .decade-slide { background-color: #e8e1e1; color: #111; width: 100%; height: 100%; }
  .decade-title { font-size: 5rem; color: #111; font-weight: bold; text-transform: uppercase; letter-spacing: 4px; margin-bottom: 10px; }
  .decade-subtitle { font-size: 2.2rem; color: #444; font-style: italic; }
</style>
</head>
<body>
HTML

first=1

# Loop through each folder (e.g., 1970s, 1980s, 1990s)
for dir in */; do
  # Check if directory exists
  [ -d "$dir" ] || continue
  
  # Clean directory name (removes trailing slash)
  decade_name="${dir%/}"
  
  # Generate Decade Division Title Slide
  if [ $first -eq 1 ]; then
    echo "  <div class=\"slide decade-slide active\"><div class=\"decade-title\">$decade_name</div><div class=\"decade-subtitle\">50 Jahre Stadtmission Windhoek</div></div>" >> slideshow.html
    first=0
  else
    echo "  <div class=\"slide decade-slide\"><div class=\"decade-title\">$decade_name</div><div class=\"decade-subtitle\">50 Jahre Stadtmission Windhoek</div></div>" >> slideshow.html
  fi

  # Loop through photos inside the decade folder
  for img in "$dir"*.jpg "$dir"*.png "$dir"*.webp; do
    [ -e "$img" ] || continue
    
    # Extract filename without directory path or extension
    base_name=$(basename "$img")
    filename="${base_name%.*}"
    
    # Replace underscores with spaces for the caption
    caption=$(echo "$filename" | tr '_' ' ')
    
    echo "  <div class=\"slide\"><img src=\"$img\"><div class=\"caption\">$caption</div></div>" >> slideshow.html
  done
done

cat << 'HTML' >> slideshow.html
<script>
  let slides = document.querySelectorAll('.slide');
  let current = 0;
  setInterval(() => {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
  }, 5000); // 5 seconds per slide
</script>
</body>
</html>
HTML

echo "slideshow.html created successfully with updated title!"
EOF
chmod +x generate.sh && ./generate.sh
