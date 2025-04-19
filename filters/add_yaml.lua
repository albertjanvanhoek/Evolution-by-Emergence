-- filters/add_yaml.lua  ────────────────────────────────────────────────
-- Voegt YAML‑front‑matter toe op basis van LaTeX‑metadata.
local utils = pandoc.utils
local stringify = utils.stringify
local sha1 = utils.sha1

function Meta(m)
  -- 1) Basisvelden uit LaTeX (\title, \author, \date)
  local meta = pandoc.Meta{}

  if m.title then      meta.title   = m.title          end
  if m.author then     meta.author  = m.author         end
  if m.date then       meta.date    = m.date           end

  -- 2) Extra velden automatisch genereren
  local id = sha1(stringify(m.title or "unknown")):sub(1,8)
  meta.id = pandoc.MetaString(id)

  -- versie vanuit omgevings­variabele (ingegeven door GitHub Actions)
  local ver = os.getenv("BOOK_VERSION") or "0.0‑dev"
  meta.version = pandoc.MetaString(ver)

  -- voorbeeld: keywords hardcoderen of uit LaTeX‑cmd \keywords{}
  meta.keywords = pandoc.MetaList{
      pandoc.MetaString("complexity"),
      pandoc.MetaString("emergence")
  }

  -- 3) Vervang de oude Meta door de nieuwe
  return meta
end
