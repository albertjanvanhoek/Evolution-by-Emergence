-- Vervang .pdf door .svg én corrigeer het pad
function Image (img)
  local p = img.src
  if p:match("%.pdf$") then
    -- 1)  .pdf  → .svg
    p = p:gsub("%.pdf$", ".svg")
    -- 2)  strip leading "docs/"
    p = p:gsub("^docs/", "")
    -- 3)  maak het pad site‑root‑relatief (../../figures/… werkt
    --     vanuit iedere pagina in /Chapters/, /Frontmatter/, /Backmatter/)
    p = "../../" .. p
    img.src = p
  end
  return img
end
