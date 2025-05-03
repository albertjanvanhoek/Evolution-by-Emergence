-- filters/pdf2svg.lua
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    -- extensie
    p = p:gsub("%.pdf$", ".svg")
    -- docs/figures/...  →  ../figures/...
    p = p:gsub("^docs/", "../")
    img.src = p
  end
  return img
end
