-- filters/pdf2svg.lua
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    -- The organizational-depth manuscript references its reproducible figure
    -- by repository path. The Pages workflow regenerates that figure and
    -- publishes a browser-safe copy in docs/figures.
    if p:match("^verification/organizational%-depth/tightness/figures/tightness%.pdf$") then
      p = "../figures/tightness.svg"
    else
      p = p:gsub("%.pdf$", ".svg")

      -- Publication/book sources are mirrored under docs/<source-dir>, while
      -- their shared figures live in docs/figures.
      if p:match("^figures/") then
        p = "../" .. p
      else
        p = p:gsub("^docs/", "../")
      end
    end

    img.src = p
  end
  return img
end
