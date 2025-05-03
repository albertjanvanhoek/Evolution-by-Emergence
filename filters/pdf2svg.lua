-- filters/pdf2svg.lua
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    p = p:gsub("%.pdf$", ".svg")   -- extensie .pdf → .svg
    p = p:gsub("^docs/", "../")    -- ../figures/...   (géén leading “/”)
    img.src = p
    -- eventueel centreren:
    -- img.attributes = img.attributes or {}
    -- img.attributes["class"] = "center"
  end
  return img
end

