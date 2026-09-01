cat << 'EOF' > generate.sh
#!/bin/bash
cat << 'HTML' > ../index.html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  body { 
    margin: 0; 
    background: #e8e1e1; 
    color: #111; 
    font-family: sans-serif; 
    display: flex; 
    justify-content: center; 
    align-items: center; 
    height: 100vh; 
    overflow: hidden; 
  }

  /* Base Slide Styling with Smooth Fade Transition */
  .slide { 
    position: absolute;
    top: 0;
    left: 0;
    width: 100%; 
    height: 100%; 
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    opacity: 0;
    visibility: hidden;
    transition: opacity 1s ease-in-out, visibility 1s ease-in-out;
  }

  /* Active Slide becomes visible and fades in */
  .slide.active { 
    opacity: 1;
    visibility: visible;
  }
  
  /* Photo Slide Styling */
  img { 
    max-width: 90vw; 
    max-height: 80vh; 
    object-fit: contain; 
    border: 3px solid #d4af37; 
    border-radius: 8px; 
    box-shadow: 0 4px 20px rgba(0,0,0,0.3); 
  }
  .caption { 
    margin-top: 15px; 
    font-size: 1.8rem; 
    color: #111; 
    background: rgba(255, 255, 255, 0.85); 
    padding: 10px 20px; 
    border-radius: 6px; 
    box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
  }
  
  /* Decade Title Slide Styling */
  .decade-slide { 
    background-color: #e8e1e1; 
    color: #111; 
  }
  .decade-title { 
    font-size: 5rem; 
    color: #111; 
    font-weight: bold; 
    text-transform: uppercase; 
    letter-spacing: 4px; 
    margin-bottom: 10px; 
  }
  .decade-subtitle { 
    font-size: 2.2rem; 
    color: #444; 
    font-style: italic; 
  }
</style>
</head>
<body>
HTML

first=1

# Scan decade subdirectories (e.g. 1970s, 1980s) inside current folder
for dir in */; do
  [ -d "$dir" ] || continue
  
  decade_name="${dir%/}"
  
  if [ $first -eq 1 ]; then
    echo "  <div class=\"slide decade-slide active\"><div class=\"decade-title\">$decade_name</div><div class=\"decade-subtitle\">50 Jahre Stadtmission Windhoek</div></div>" >> ../index.html
    first=0
  else
    echo "  <div class=\"slide decade-slide\"><div class=\"decade-title\">$decade_name</div><div class=\"decade-subtitle\">50 Jahre Stadtmission Windhoek</div></div>" >> ../index.html
  fi

  for img in "$dir"*.jpg "$dir"*.png "$dir"*.webp; do
    [ -e "$img" ] || continue
    
    base_name=$(basename "$img")
    filename="${base_name%.*}"
    caption=$(echo "$filename" | tr '_' ' ')
    
    # Path formatted for index.html located one directory level up
    echo "  <div class=\"slide\"><img src=\"slideshow_photos/$img\"><div class=\"caption\">$caption</div></div>" >> ../index.html
  done
done

cat << 'HTML' >> ../index.html
<script>
  let slides = document.querySelectorAll('.slide');
  let current = 0;
  setInterval(() => {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
  }, 8000); // 8 seconds per slide
</script>
</body>
</html>
HTML

echo "Successfully generated index.html in parent folder!"
EOF
chmod +x generate.sh && ./generate.sh