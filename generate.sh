#!/bin/bash
cat << 'HTML' > slideshow.html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  body { margin: 0; background: #111; color: #fff; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; overflow: hidden; }
  .slide { display: none; text-align: center; position: relative; width: 100%; height: 100%; }
  .active { display: flex; flex-direction: column; justify-content: center; align-items: center; }
  img { max-width: 90vw; max-height: 80vh; object-fit: contain; border: 3px solid #d4af37; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.8); }
  .caption { margin-top: 15px; font-size: 1.5rem; color: #f0e68c; background: rgba(0,0,0,0.6); padding: 8px 16px; border-radius: 4px; }
</style>
</head>
<body>
HTML

first=1
for img in *.jpg *.png *.webp; do
  [ -e "$img" ] || continue
  filename="${img%.*}"
  caption=$(echo "$filename" | tr '_' ' ')
  
  if [ $first -eq 1 ]; then
    echo "  <div class=\"slide active\"><img src=\"$img\"><div class=\"caption\">$caption</div></div>" >> slideshow.html
    first=0
  else
    echo "  <div class=\"slide\"><img src=\"$img\"><div class=\"caption\">$caption</div></div>" >> slideshow.html
  fi
done

cat << 'HTML' >> slideshow.html
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
echo "slideshow.html created successfully!"
