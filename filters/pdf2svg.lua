-- Vervang .pdf door .svg in elk afbeeldingspad
function Image (img)
  if img.src:match("%.pdf$") then
    img.src = img.src:gsub("%.pdf$", ".svg")
  end
  return img
end
