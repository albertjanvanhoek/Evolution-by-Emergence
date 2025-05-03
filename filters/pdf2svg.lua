-- Zet .../layers.pdf om naar /figures/layers.svg
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    p = p:gsub("%.pdf$", ".svg")  -- extensie
    p = p:gsub("^docs/", "/")     -- /figures/...
    img.src = p
  end
  -- optioneel centreren door een klasse toe te voegen
  -- img.attributes = img.attributes or {}
  -- img.attributes["class"] = "center"
  return img
end
