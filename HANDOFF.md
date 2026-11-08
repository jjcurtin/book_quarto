# Project Handoff — Intro to Quarto workshop (book_quarto)

Last updated: 2026-11-08 (end of third session). Read this and [dry.md](dry.md) before continuing.

## What we are building

A teaching resource on Quarto for students in the UW–Madison **masters in data science** program (the same students who took John's Git/GitHub workshop). Modeled closely on `~/github/book_git` — read its `HANDOFF.md` for the full pattern.

- **One ~60-minute, hands-on workshop.** Students follow along live on their laptops, building one running example in their own `mendota_ice` repo.
- Each unit is its own `.qmd` that renders as **both** a book chapter (GitHub Pages) and a standalone revealjs deck (Posit Connect Cloud), exactly like book_git.
- Some units are **taught live**; others are **reference-only** for students to work through afterward.
- Topics: Quarto **reports**, **slide decks**, and **manuscripts/papers**, plus (reference) reusing code across all three (the DRY approach in `dry.md`).
- **Terminal-first**: John teaches everything from the terminal (`quarto render`, `quarto publish`). Never tell students to click Render/Publish buttons in RStudio or elsewhere.

## Workshop outline

| # | Unit | File | Live? | Status / content |
|---|---|---|---|---|
| — | Landing page + setup | `index.qmd` | Before workshop | **Setup section done** (see below). Landing intro, book organization, and deck-links table still TODO (placeholder comment at top). |
| 1 | What is Quarto? | `01_intro.qmd` | Yes (~5 min) | **Drafted, published to Connect Cloud.** 8 slides: objectives; what Quarto is (`.qmd` = markdown + code + YAML → reports/decks/manuscripts); R vs RStudio vs Quarto table; render pipeline (`quarto render report.qmd` + mermaid: `.qmd` → engine knitr/Jupyter → `.md` → Pandoc → output; plants the fresh-session gotcha); why Quarto (old way vs. Quarto table); quick notes (own CLI program like Git; works with Python via `{python}`; R Markdown successor); source vs. output; recap + "Next up" → Mendota report. No running-example intro or beer hook here (save for Unit 2). |
| 2 | Quarto report | `02_report.qmd` | Yes (~20 min) | **Drafted, trimmed, partly reviewed by John (20 slides incl. title).** Flow: beer hook → our data → what we will build → create file (`touch report.qmd`) → YAML header → render (open HTML via Files pane → View in Web Browser) → markdown headings/text/lists (one merged slide) → blank lines matter (John: "Don't do this step today") → Your turn (blank-line test marked "Try later") → code chunks (labeled `setup` **from the start**; no rename) → hide the messages (`message: false`, `include: false`) → add a figure → the figure (executed, `theme_minimal()`) → inline R (`means` chunk + `mean_1800s`/`mean_recent` = 114/81; not the period table) → fresh-session demo (`n_winters <- 171` in console) → the error (real error text; bullet about green ▶ chunks) → Your turn (`min(ice$ice_days)`) → **"Your turn: what to type" solution slide** (incl. "sentences must come after the `means` chunk" and "delete/fix the `n_winters` sentence") → where we are. Trims done 2026-11-08: merged headings+text slides, cut "Too much output", merged two inline slides, moved "running chunks in RStudio" to the chunk-options reference unit. Remaining options if more time is needed: cut "What we will build" or "The figure in your report", or make the first Your turn follow-along. Small loose end: "The error" slide's last bullet suggests `nrow(ice)` inline, which students no longer see earlier. Reads local `data/mendota_ice.csv`. Original plan: Very simple YAML. Markdown: headings, lists, bold, **blank lines matter**. Code: code chunks, **setup chunk** (teach `#\| message: false` / `include: false` here only), **inline R**, and the **render-runs-in-a-fresh-session** gotcha (demo: create object in console, use it in doc, render fails). Open with the Mendota/beer hook. |
| 3 | Render & publish | `03_publish.qmd` | Yes | **First draft 2026-11-08 (13 slides incl. title).** Covers: two ways to share; `report_files/`; `embed-resources: true` (first nested YAML); brief `--to docx`/`--to typst` slide; free plan = public + listed on profile; publish (renders locally, uploads output); first-time device-code authorization; title set at first publish; republish via "Publish update to:" menu (not Y/n — Connect Cloud provider has no `publishRecord`, verified in quarto.js 1.11.9) and `_publish.yml`; Your turn adds `max(ice$ice_days)` sentence and republishes. **Deliberately no Git commit** (John: should ignore `*.html` first; not spending time on it now). Verified: single-file HTML render creates no `.quarto/`, but `--to docx`/`--to typst` render **does** create `.quarto/` → handle in a later `.gitignore` discussion. **Windows risk:** Quarto's interactive prompts may misbehave in Git Bash (mintty); test publish on Windows during the setup dry run. Original plan: Render locally to a single self-contained HTML (`embed-resources: true`); publish to Connect Cloud. **First publish includes the one-time Connect Cloud authorization, done live** (not in setup). Possibly show switching `format:` (docx/typst) as a one-line change. Good moment to add `/.quarto/` to students' `.gitignore` (GitHub's R template lacks it). |
| 4 | Slide decks (revealjs) | | Yes | Slide breaks (`##`, `---`), presenter notes (`::: {.notes}`, speaker view `S`), incremental (`. . .`) vs duplicate-slide builds, columns, figure sizing/overflow, code on slides, `execute: echo: false`, theme/logo/footer, print to PDF; publish the deck. **Likely place to trim** for time. |
| 5 | Manuscripts/papers | | Yes (important) | **Approach still open — see below.** Core: citations (`refs.bib`, `@key`, CSL), cross-refs (`@fig-`, `@tbl-`), author/affiliation/abstract YAML, docx output. |
| — | Advanced markdown for reports | | Reference | Italics, inline code, numbered/nested lists, URL links, images, pipe tables, math, callouts. |
| — | Chunk options & tables | | Reference | `echo`, `warning`, `fig-cap`, `fig-width`, etc.; tables (tinytable recommended). Also running chunks interactively in RStudio (moved out of Unit 2): green ▶ or Ctrl/Cmd+Shift+Enter; handy for testing, but runs in the console session, so a report can work there and still fail to render; `quarto render` is the real test. |
| — | Advanced slide formatting | | Reference | John's CSS files (`slides_teaching.css`, `utilities.css`) and conventions. |
| — | YAML in depth | | Reference | Other YAML settings John uses for reports, decks, and papers. Where YAML lives: document header vs. folder (`_metadata.yml`) vs. project (`_quarto.yml`), and how they merge. Coordinate with DRY unit (also touches `_quarto.yml`). |
| — | DRY: reuse code across products | | Reference | `knitr::read_chunk()` approach in `dry.md`. Also Quarto projects/`_quarto.yml`, `freeze`. |
| — | Appendices | | Reference | Cheatsheet. Possibly: Git tie-in (what to ignore), websites/books, parameterized reports. (Prerequisites now live in `index.qmd`.) |

Rough live timing: Unit 1 ~5, Unit 2 ~20, Unit 3 ~10, Unit 4 ~15, Unit 5 ~15 → **~65 min vs. 60** — trim (most likely Unit 4) or move content to reference.

### Open: what to teach in the manuscript unit

Quarto's `manuscript` project type is built around `{{</* embed */>}}` from notebooks, which fixes figure size/formatting in the source notebook — the reason we rejected embed for DRY. Options: simple article `.qmd` (typst/docx; lowest overhead, `read_chunk()` stays in DRY unit) — Claude's recommendation; manuscript project with `read_chunk()` in `index.qmd`; apaquarto. Not yet decided.

## Setup (`index.qmd` "Before the workshop") — decisions

Assumes Git workshop setup (Git; **Git Bash on Windows**; GitHub account; SSH key). Commands in Terminal / Git Bash / RStudio terminal. Six steps:

1. **Install Quarto separately** from quarto.org (don't rely on RStudio's bundled copy). Reasons: bundled copy is not reliably on the terminal PATH (on John's Linux box it isn't: bundled 1.10.18 at `/usr/lib/rstudio/resources/app/bin/quarto/bin/quarto`, not on PATH; system 1.11.9 at `/opt/quarto` is); bundled version depends on RStudio release; RStudio uses the PATH copy if newer, so no conflict.
2. **`quarto --version` ≥ 1.9** (needed for `quarto publish posit-connect-cloud`). Troubleshooting: "command not found" → reinstall, new terminal; too old → `which quarto`, reinstall; `quarto check`.
3. **Connect Cloud account** at connect.posit.cloud, sign up with GitHub; free plan.
4. **GitHub repo `mendota_ice`** (public or private), with **`R` .gitignore template** (also gives first commit so clone has tracking).
5. **Clone via SSH** into `~/github` (their repos folder from the Git workshop); `ls -a` shows `.git` and `.gitignore`.
6. **Download the data** (added 2026-11-08): copy-paste `mkdir data` + `curl -fsSL -o data/mendota_ice.csv <raw URL>`; verify with `head -3`. curl ships with macOS, Windows 10/11, and Git Bash. John rejected a template repo (wants students to make their own repo). Reason for local data: the raw URL was too long for slide code.

Deliberately **not** in setup: Connect Cloud terminal authorization (done live), tidyverse (students already have it), RStudio project (`.Rproj`) — John teaches projects in his spring course and fall students may not use them yet.

### Paths / working directory (decided 2026-11-08)

- Live units keep `report.qmd` (and later decks/papers) at the **repo root** with plain relative paths (`read_csv("data/mendota_ice.csv")`). No `.Rproj`, no `_quarto.yml` in students' repos.
- Verified in Quarto 1.11.9: `quarto render` runs in the `.qmd`'s folder regardless of where it's invoked; it ignores `.Rproj`. A `.qmd` in a subfolder breaks relative paths. `_quarto.yml` with `project: execute-dir: project` sets the working dir to the project root (render only; RStudio's interactive chunks don't read it). RStudio's default runs chunks interactively from the document's folder.
- **TODO (DRY / YAML-in-depth reference units):** introduce `here::here()` (finds root via `.Rproj`, `.here`, or `.git` — not `_quarto.yml`; students' repos have `.git`) and Quarto projects (`_quarto.yml`, `execute-dir`, plus side effects: render-all, project YAML, `freeze`, whole-project inspection on publish). Optionally mention `.Rproj` there as complementary (controls the interactive session, not render).

**Untested — do before the workshop:** on a clean **Windows laptop in Git Bash**: setup steps 1–2 (old forum reports say Git Bash needed `quarto.cmd`; unknown if still true), step 6 (curl), and Unit 3's `quarto publish` (interactive Y/n and menu prompts may misbehave in mintty; fallback: PowerShell or RStudio's terminal). Also: John's own first-publish run-through to check the Unit 3 authorization slide against what students actually see.

## Running example: Lake Mendota ice cover

- Story: Lake Mendota days of ice cover are declining. Hook (for Unit 2): per the State Climatology Office, the frozen/open rule came from Birge and Juday asking whether they could row a case of beer from Picnic Point to Maple Bluff. SCO calls it oral tradition (attributed to Reid Bryson), so the slide frames it as "the story".
- Analyses stay **descriptive**: figure of `ice_days` by winter; inline numbers; period summary table.
- Planned table: summary by period — 1855–1899, 1900–1949, 1950–1999, 2000–2026 — winters (n), mean, SD, shortest, longest. Means (verified 2026-11-08, grouping on `year`): 114 → 102 → 100 → 81 (n = 44, 50, 50, 27). Inline numbers from the same summary object. Optional records slide (shortest 21 days 2001-02, 44 days 2023-24; longest 161 days 1880-81).
- Live workshop shows only figure + inline numbers (`mean_1800s`, `mean_recent`, `min`/`max` of `ice_days`); the manuscript unit needs a ready-made table chunk for the `@tbl-` demo.
- Students work in their own `mendota_ice` repo (starts with `.gitignore` + `data/mendota_ice.csv` from setup). By end of Unit 3 their `report.qmd` has: YAML (title, author, `date: today`, `format: html: embed-resources: true`), `setup` chunk (`message: false`), Background section + list, `ice_plot` chunk, `means` chunk, inline sentences (means, shortest, longest), plus `_publish.yml`. **Undecided:** where John's own demo/solution files live (e.g., a folder in book_quarto vs. a separate repo). A test demo `report.qmd` existed only in the scratch dir (not saved).

### Data (done)

| File | Contents |
|---|---|
| `data_raw/ntl33_v14.csv` | Raw EDI download (2026-11-07), untouched. "v14" is EDI's entity name, **not** the package version (ver 40). |
| `data_raw/mak_mendota_ice.R` | Prep script: Mendota only, winters 1855-56 onward, columns `winter` ("1855-56"), `year` (year the winter **ends**), `ice_days`; `stopifnot()` checks; citation in header. |
| `data/mendota_ice.csv` | Clean data: 171 winters (1855-56 to 2025-26), no gaps/NAs. Verified against SCO records. |
| `refs.bib` | `@magnuson2026` (EDI ver 40, DOI 10.6073/pasta/6a95bee73799927cbafbf87393be7038). `@dataset` type; proper nouns brace-protected. Tested with citeproc + APA CSL. |

- Raw EDI quirks handled: incomplete 1852-53/1853-54, missing 1854-55; mid-winter thaws make `duration` ≠ `ice_off - ice_on` (dates dropped).
- Students download the CSV before the workshop (setup step 6) from `https://raw.githubusercontent.com/jjcurtin/book_quarto/main/data/mendota_ice.csv` — works only if book_quarto stays **public** and `data/mendota_ice.csv` stays at that path on `main`. Reports read it with `read_csv("data/mendota_ice.csv")` (relative path; `report.qmd` sits at the repo root). The DRY unit can introduce `here::here()`.

## Publishing / build setup

- Same mechanism as book_git: no committed `_quarto.yml`; `publish.sh book|slides [file]` copies `_quarto_book.yml` or `_quarto_slides.yml` to `_quarto.yml`, publishes, then removes it and build output. (`slides_wide` is gone from this repo — not wanted.) Units must work as book chapters and standalone decks → **no `@sec-` cross-refs between units**.
- `_quarto_slides.yml` has `project: render: ["*.qmd"]`. Why: with a `_quarto.yml` present, `quarto publish` inspects the whole project, treats `.md` files as inputs, and expands `{{</* include */>}}` even inside code fences — `dry.md` line 116's example include broke publishing. Book config is unaffected (only `chapters:` are processed).
- `_quarto_book.yml` chapters: `index.qmd`, `01_intro.qmd`, `02_report.qmd`, `03_publish.qmd`. Add new units as they're written.
- `.gitignore` now has `/.quarto/` and `**/*.quarto_ipynb`. Note `book_quarto.Rproj` is (presumably deliberately) git-ignored.
- **How `quarto publish posit-connect-cloud` works**: renders locally (same pipeline, your R/packages), then uploads only the output; Connect Cloud never runs code. (Publishing *from GitHub* in the Connect Cloud UI is different: it renders on Posit's servers.)
- **Content title gotcha (verified in quarto.js 1.11.9)**: the Connect Cloud title is sent **only when content is first created**, from YAML `title:` (else the file name). Updates never change it. A `#` heading is not the document title. → Every unit puts its title in YAML `title:` (book chapter title and deck title slide both work; verified). To rename existing content: rename in Connect Cloud UI, or delete it there **and** remove its record from `_publish.yml`, then republish (new URL).
- Mermaid chunks need `%%| echo: false` (both configs set `echo: true`, so the diagram source otherwise prints). Mermaid renders well on slides but small in the book.
- Pipe-table column widths: `: {tbl-colwidths="[20,30,50]"}` works.
- Authoring conventions (from book_git): unit title in YAML `title:`; one `##` per slide; long `---` separators; builds by slide duplication; `[term]{.uwred}`; `gap-*` spacers; `.hl` tables; `callout-wide` > `callout-important` "Your turn"/"Next up"; appendices in prose with `#sec-` labels.
- Teaching Quarto *in* Quarto: show unexecuted chunks with ```` ```{{r}} ```` (**verified** in book + deck, Unit 2); show inline R literally with `` `r knitr::inline_expr("x")` `` — works inside ```` ```markdown ```` fences too (knitr evaluates inline `r` even inside plain code fences, so a bare `` `r x` `` there would execute). Units needing real output (figure, numbers) have a hidden `include: false` setup chunk reading `here::here("data/mendota_ice.csv")`. Escape shortcodes as `{{</* include */>}}` (not yet verified).
- Visual check workflow used this session: render a copy in the scratch dir, screenshot slides with `google-chrome --headless=new --screenshot ... "file://.../01_intro.html#/<slide-id>"` (hash must be the slide id, not a number).

### CSS: pending decision

Three additions to slide_decks' `presentation.css` (2026-11-05) not yet in the teaching CSS:

| Addition | Recommendation |
|---|---|
| `.reveal sup { font-size: 0.8em !important; }` | Port to `slides_teaching.css` in **both** book_git and book_quarto. |
| `.reveal h2:empty { display: none; }` | Port (harmless). |
| UW crest `body::after` on the red bar | John's call — would duplicate `logo: uwlogo.png`. |

## Conventions

- **snake_case across the board** (objects, functions, files, folders, chunk labels, repo names → `mendota_ice`); hyphens only where required (`fig-`/`tbl-`/`sec-` prefixes, e.g., `fig-ice_days`).
- `dry.md` still uses hyphenated chunk labels → convert to snake_case after verifying `@fig-ice_days`-style cross-refs work.
- **Slide text: one idea per line** (John's edits in commit `0b55572`, see `01_intro.qmd`). John glances at a slide and lectures in his own words; multi-sentence lines force him to read them aloud.
  - Never put two or more sentences/ideas in one slide paragraph. Split them into bullets.
  - A short lead-in line stays as plain text, then bullets (e.g., "You use them together:" followed by three bullets).
  - A `[label]{.uwred}` line sits on its own line with its supporting bullets below; separate label groups with `gap-md`.
  - Keep the wording; just split it. Bullets can be full sentences or fragments.
  - Book-only prose (appendices, reference-only units) can stay as paragraphs.

## dry.md (done)

Teaching reference for the `read_chunk()` DRY workflow (structure, `params: product:` + `_setup.qmd` with `theme_set()`, per-product YAML sizing, compute/display split for tables, showing code, `#| file:` variant, freeze/caching, pitfalls, teaching notes). Verified in Quarto 1.11.9 except freeze/cache staleness advice and `cache.extra`.

## Housekeeping / state at end of session

- book_quarto: last commit `0b55572` (John's bullet-style edits to `01_intro.qmd`). **Uncommitted at end of session 3**: `01_intro.qmd`, `HANDOFF.md`, `_publish.yml`, `_quarto_book.yml`, `index.qmd` (setup step 6); **untracked**: `02_report.qmd`, `03_publish.qmd`, `_freeze/` (appeared this session, presumably from a book render with `freeze: auto` — decide whether to commit it; book_git's practice is the guide).
- Units 2 and 3 are not yet published as decks or in the book.
- `_publish.yml` **fixed** (2026-11-08): John deleted the deck and the file, then republished. Lesson: an *empty* `_publish.yml` makes Quarto warn "Unexpcted format ... not writing to publish history" and silently skip recording (it must be a YAML list or absent). To drop a record, edit it out; to reset, delete the file — never leave it empty.
- book_git: **uncommitted** YAML title fix for units `01_setup.qmd`–`08_branches.qmd` (verified book + deck renders). John is renaming those decks manually on Connect Cloud (URLs already shared, so no republish).
- `index.qmd` book TOC shows only the top `##` heading, not "Before the workshop"/steps (same `##` pattern as book_git's index). Minor; not investigated.

## Next steps (John will direct)

1. Commit book_quarto (incl. Units 2–3; decide on `_freeze/`) and book_git (staged YAML title fixes).
2. John reviews Units 2–3 in full; publish their decks and the book.
3. Draft Unit 4 (slide decks) — likely trim target; then decide manuscript approach and draft Unit 5. Re-check total live timing (~65 vs. 60 min).
4. Decide where John's demo/solution files live; save a demo `report.qmd` that matches Units 2–3.
5. Students' `.gitignore` for outputs (`*.html`, `*_files/`, `/.quarto/`) and committing their work — deliberately skipped in Unit 3; decide where it goes (later live unit or reference/appendix).
6. Fill in `index.qmd` landing page (intro, organization, deck-links table).
7. Windows dry run (see Setup "Untested").
8. Decide CSS ports. Reference units (incl. YAML in depth, here::here/Quarto projects, chunk options with the moved RStudio-chunks content), cheatsheet, `dry.md` snake_case labels.
