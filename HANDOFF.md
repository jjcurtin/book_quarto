# Project Handoff — Intro to Quarto workshop (book_quarto)

Last updated: 2026-11-07 (end of first planning session). Read this and [dry.md](dry.md) before continuing.

## What we are building

A teaching resource on Quarto for students in the UW–Madison **masters in data science** program (the same students who took John's Git/GitHub workshop). Modeled closely on `~/github/book_git` — read its `HANDOFF.md` for the full pattern.

- **One ~60-minute, hands-on workshop.** Students follow along live on their laptops, building one running example.
- Each unit is its own `.qmd` that renders as **both** a book chapter (GitHub Pages) and a standalone revealjs deck (Posit Connect Cloud), exactly like book_git.
- Some units are **taught live**; others are **reference-only** for students to work through afterward.
- Topics: Quarto **reports**, **slide decks**, and **manuscripts/papers**, plus (reference) reusing code across all three (the DRY approach in `dry.md`).

## Workshop outline (agreed so far; manuscript unit still open)

| # | Unit | Live? | Content decided |
|---|---|---|---|
| 1 | Quarto report | Yes | Very simple YAML. Markdown: headings, lists, bold, **blank lines matter**. Code: code chunks, **setup chunk** (teach `#\| message: false` / `include: false` here only, to hide package startup messages), **inline R**, and the **render-runs-in-a-fresh-session** gotcha (demo: create object in console, use it in doc, render fails). |
| 2 | Render & publish | Yes | Render locally to a single self-contained HTML (`embed-resources: true`); publish to Posit Connect Cloud. Possibly show switching `format:` (docx/typst) as a one-line change. |
| 3 | Slide decks (revealjs) | Yes | What's new beyond Unit 1 markdown: slide breaks (`##`, `---`), **presenter notes** (`::: {.notes}`, speaker view `S`), incremental content (`. . .`) vs John's duplicate-the-slide builds, columns, image/figure sizing and overflow, code on slides, `execute: echo: false` in YAML, built-in theme/logo/footer, print to PDF. End by publishing the deck to Connect Cloud. |
| 4 | Manuscripts/papers | Yes (important) | **Open — see below.** Core content regardless: citations (`refs.bib`, `@key`, CSL), cross-references (`@fig-`, `@tbl-`), author/affiliation/abstract YAML, docx output for Word-using coauthors; consider apaquarto. |
| — | Advanced markdown for reports | Reference | Italics, inline code, numbered/nested lists, **URL links** (moved here from Unit 1), images, pipe tables, math, callouts. |
| — | Chunk options & tables | Reference | `echo`, `warning`, `fig-cap`, `fig-width`, etc.; tables (tinytable recommended). |
| — | Advanced slide formatting | Reference | Share John's CSS files (`slides_teaching.css`, `utilities.css`) and conventions. |
| — | DRY: reuse code across products | Reference | The `knitr::read_chunk()` approach documented in `dry.md` (John chose this "option 1"). Also covers Quarto projects/`_quarto.yml`, `freeze`. |
| — | Appendices | Reference | Prerequisites/setup (R, RStudio, Quarto ≥ 1.9 for `quarto publish posit-connect-cloud`, packages, Connect Cloud account + one-time terminal authorization — without it publish exits silently), cheatsheet. Possibly: Git tie-in (what to ignore), websites/books, parameterized reports. |

Rough live timing (tight): Unit 1 ~20 min, Unit 2 ~10, Unit 3 ~15, Unit 4 ~15. Move content to reference rather than rush.

### Open: what to teach in the manuscript unit

Quarto's `manuscript` project type is built around `{{< embed >}}` from notebooks, which fixes figure size/formatting in the source notebook — the reason we rejected embed for DRY (John needs figures/tables to adapt per product). Options to weigh: a simple article `.qmd` (typst/docx) + `read_chunk()`; manuscript project using `read_chunk()` inside `index.qmd` with embed mentioned as the native alternative; apaquarto. Not yet decided — revisit with John.

## Running example: Lake Mendota ice cover

- Story: Lake Mendota (Madison) days of ice cover are declining. Fun hook for Unit 1: per the State Climatology Office, Mendota's frozen/open rule came from Birge and Juday asking whether they could row a case of beer from Picnic Point to Maple Bluff.
- Analyses stay **descriptive** (avoid trend tests/autocorrelation): figure of `ice_days` by winter; inline numbers; a period summary table.
- Planned table (reference units + manuscript): summary by period — 1855–1899, 1900–1949, 1950–1999, 2000–2026 — with winters (n), mean, SD, shortest, longest. Preview on older data: means 114 → 102 → 99 → 85. Inline numbers should come from the same summary object (DRY point). Optional fun slide: records table (shortest 21 days 2001-02, 44 days 2023-24; longest 161 days 1880-81).
- Live workshop shows only figure + inline numbers (tables are in a reference unit); the manuscript unit will need a ready-made table chunk for the `@tbl-` demo.

### Data (done)

| File | Contents |
|---|---|
| `data_raw/ntl33_v14.csv` | Raw EDI download (John, 2026-11-07), untouched. "v14" is EDI's entity name, **not** the package version (ver 40). |
| `data_raw/mak_mendota_ice.R` | Prep script: Mendota only, winters 1855-56 onward, columns `winter` ("1855-56"), `year` (year the winter **ends**, matching EDI), `ice_days`; `stopifnot()` checks; citation in header. |
| `data/mendota_ice.csv` | Clean data: 171 winters (1855-56 to 2025-26), no gaps/NAs. Verified against SCO records (161, 151, 21, 44, 71). |
| `refs.bib` | `@magnuson2026` (EDI ver 40, DOI 10.6073/pasta/6a95bee73799927cbafbf87393be7038). `@dataset` type; proper nouns brace-protected so APA sentence case keeps "Madison Lakes Area". Tested with citeproc + APA CSL. |

- Raw EDI quirks handled by the simplification: incomplete 1852-53/1853-54, missing 1854-55; mid-winter thaws make `duration` ≠ `ice_off - ice_on` (we drop the dates).
- Students will read the CSV from the raw GitHub URL (`https://raw.githubusercontent.com/jjcurtin/book_quarto/main/data/mendota_ice.csv`) — works only after the repo is public and pushed. The DRY unit can switch to a local `data/` + `here::here()`.

## Publishing / build setup (copied from book_git)

- Same mechanism as book_git: no committed `_quarto.yml`; `publish.sh book|slides|slides_wide [file]` copies the matching `_quarto_*.yml` to `_quarto.yml`, publishes, then removes it and build output. Every unit must render as both a book chapter and a standalone deck → **no `@sec-` cross-refs between units** (use plain-text pointers).
- Copied: `_quarto_book.yml`, `_quarto_slides.yml`, `publish.sh`, `book.css`, `slides_teaching.css`, `slides_wide_teaching.css`, `utilities.css`, `uwlogo.png`. **Not** copied: `_publish.yml` (book_git's Connect Cloud IDs; a new one is created on first publish).
- `_quarto_book.yml` edited: title "Introduction to Quarto" (placeholder), `site-url: https://jjcurtin.github.io/book_quarto/`, `repo-url` book_quarto, chapters = `index.qmd` only (doesn't exist yet).
- **Note:** `_quarto_slides_wide.yml` was copied but is no longer in the folder at session end (John may have removed it). `publish.sh slides_wide` will fail without it — confirm whether wide slides are wanted.
- Authoring conventions to follow (from book_git): units slide-formatted (`#` title, one `##` per slide, long `---` separators), builds by slide duplication, `[term]{.uwred}`, `gap-*` spacers, `.hl` tables, `callout-wide` > `callout-important` "Your turn"/"Next up"; appendices in prose with `#sec-` labels.
- Teaching Quarto *in* Quarto: show unexecuted chunks with ```` ```{{r}} ````; escape shortcodes as `{{</* include */>}}` (verify both before wide use). Consider showing real rendered output by running the example code in the decks.

### CSS: pending decision

`utilities.css` is identical across slide_decks, book_git, book_quarto. Three additions were made to slide_decks' `presentation.css` on 2026-11-05, after book_git last synced:

| Addition | Recommendation |
|---|---|
| `.reveal sup { font-size: 0.8em !important; }` | Port to `slides_teaching.css` and `slides_wide_teaching.css` in **both** book_git and book_quarto (global font rule makes footnote markers full size). |
| `.reveal h2:empty { display: none; }` | Port (harmless; hides heading/red bar on untitled slides). |
| UW crest `body::after` on the red bar | John's call — teaching decks already use `logo: uwlogo.png` top-right, so it would duplicate. |

Awaiting John's go-ahead. Other theme differences between presentation.css and the teaching CSS are long-standing/deliberate.

## Conventions

- **snake_case across the board** (objects, functions, files, folders, chunk labels); hyphens only where required (Quarto `fig-`/`tbl-`/`sec-` prefixes, e.g., `fig-ice_days`). Recorded in this project's `AGENTS.md` and `~/github/lab_support/AGENTS.md`.
- `dry.md` still uses hyphenated chunk labels (`load-data`, `fig-scores`, `scores-data`, `fit-model`) → convert to snake_case after verifying underscore labels cross-reference correctly (e.g., `@fig-ice_days`).

## dry.md (done)

Teaching reference for the `read_chunk()` DRY workflow: structure, script conventions, `params: product:` + `_setup.qmd` with `theme_set()`, per-product YAML sizing, compute/display split for tables, showing code (incl. appendix via `ref.label`), `#| file:` variant, freeze/caching, pitfalls, teaching notes. Behaviors verified in Quarto 1.11.9: header and `#| label:` both pull code; typo label → chunk silently disappears; duplicate labels across scripts → last read wins; `#| file:` typo → error; ggplot default theme applied at print time; `knitr::all_labels()` appendix includes setup chunk and all script sections. Not verified: freeze/cache staleness advice and `cache.extra`.

## Housekeeping

- book_git `site-url` bug fixed and committed by John (`001fa0c`). lab_support AGENTS.md committed (`fbd176b`).
- **book_quarto: nothing committed yet** (everything above is untracked; `AGENTS.md` modified).
- book_quarto `.gitignore` lacks Quarto entries — suggested adding `/.quarto/` and `**/*.quarto_ipynb` (as in book_git); not yet done.
- Leftover objects in John's R session from exploration (`ice_raw`, `mendota`, `edi`, `edi_me`, `tmp_rda`, `b`, `old`, `p`, `h`) — safe to `rm()`.

## Next steps (John will direct)

1. Commit current work; decide on `.gitignore` additions and `_quarto_slides_wide.yml`.
2. Decide CSS ports (sup, h2:empty, crest) for book_git + book_quarto.
3. Decide the manuscript-unit approach.
4. Draft `index.qmd` (landing page, live vs reference, deck links table) and Unit 1 (`01_report.qmd` or similar) plus the student example `report.qmd` using `data/mendota_ice.csv`.
5. Prerequisites appendix and cheatsheet.
6. Convert `dry.md` labels to snake_case.
