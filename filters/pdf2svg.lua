-- filters/pdf2svg.lua
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    p = p:gsub("%.pdf$", ".svg")

    -- LaTeX sources are converted to docs/<source-dir>/*.md, while shared
    -- figures live in docs/figures. A source reference such as
    -- figures/example.pdf therefore needs to move one level up in Markdown.
    if p:match("^figures/") then
      p = "../" .. p
    else
      p = p:gsub("^docs/", "../")
    end

    img.src = p
  end
  return img
end
