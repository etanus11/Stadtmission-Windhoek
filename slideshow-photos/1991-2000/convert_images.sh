# 1. Moire-Muster reduzieren und Kontrast schärfen (Blaupausen)
convert image17.jpg -blur 0x1 -level 20%,80% -sharpen 0x2 plan_sueden_westen.png
convert image18.jpg -blur 0x1 -level 20%,80% -sharpen 0x2 grundriss.png

# 2. Textdokument säubern (Graustufen & Schwellenwert)
convert image16.jpg -colorspace gray -threshold 60% dokument_stadtmission.png
