# Project Handoff — Intro to Quarto workshop (book_quarto)

Last updated: 2026-11-08 (fifth session). Read this and [dry.md](dry.md) before continuing.

## What we are building

A teaching resource on Quarto for students in the UW–Madison **masters in data science** program (the same students who took John's Git/GitHub workshop). Modeled closely on `~/github/book_git` — read its `HANDOFF.md` for the full pattern.

- **One ~60-minute, hands-on workshop.** Students follow along live on their laptops, building one running example in their own `mendota_ice` repo.
- Each unit is its own `.qmd` that renders as **both** a book chapter (GitHub Pages) and a standalone revealjs deck (Posit Connect Cloud), exactly like book_git.
- Some units are **taught live**; others are **reference-only** for students to work through afterward.
- Topics: Quarto **reports**, **slide decks**, and **papers** (a simple paper `.qmd`, not the manuscript project type), plus (reference) reusing code across all three (the DRY approach in `dry.md`). Live order follows a project's lifecycle: report → slides → paper.
- **Terminal-first**: John teaches everything from the terminal (`quarto render`, `quarto publish`). Never tell students to click Render/Publish buttons in RStudio or elsewhere.

## Workshop outline

| # | Unit | File | Live? | Status / content |
|---|---|---|---|---|
| — | Landing page + setup | `index.qmd` | Before workshop | **Setup section done** (see below). **Landing page drafted session 5** (intro, organization, deck-links table, "How to use this book" at the end); not yet reviewed by John. |
| 1 | What is Quarto? | `01_intro.qmd` | Yes (~5 min) | **Drafted, published to Connect Cloud.** 8 slides: objectives; what Quarto is (`.qmd` = markdown + code + YAML → reports/decks/manuscripts); R vs RStudio vs Quarto table; render pipeline (`quarto render report.qmd` + mermaid: `.qmd` → engine knitr/Jupyter → `.md` → Pandoc → output; plants the fresh-session gotcha); why Quarto (old way vs. Quarto table); quick notes (own CLI program like Git; works with Python via `{python}`; R Markdown successor); source vs. output; recap + "Next up" → Mendota report. No running-example intro or beer hook here (save for Unit 2). |
| 2 | Quarto report | `02_report.qmd` | Yes (~20 min) | **Drafted, trimmed, partly reviewed by John (20 slides incl. title).** Flow: beer hook → our data → what we will build → create file (`touch report.qmd`) → YAML header → render (open HTML via Files pane → View in Web Browser) → markdown headings/text/lists (one merged slide) → blank lines matter (John: "Don't do this step today") → Your turn (blank-line test marked "Try later") → code chunks (labeled `setup` **from the start**; no rename) → hide the messages (`message: false`, `include: false`) → add a figure → the figure (executed, `theme_minimal()`) → inline R (`means` chunk + `mean_1800s`/`mean_recent` = 114/81; not the period table) → fresh-session demo (`n_winters <- 171` in console) → the error (real error text; bullet about green ▶ chunks) → Your turn (`min(ice$ice_days)`) → **"Your turn: what to type" solution slide** (incl. "sentences must come after the `means` chunk" and "delete/fix the `n_winters` sentence") → where we are. Trims done 2026-11-08: merged headings+text slides, cut "Too much output", merged two inline slides, moved "running chunks in RStudio" to the chunk-options reference unit. Remaining options if more time is needed: cut "What we will build" or "The figure in your report", or make the first Your turn follow-along. "The error" slide (session 4): "This is a feature:" has only the rebuild bullet; a separate "To fix it:" group says to add `n_winters <- nrow(ice)` to a chunk above the sentence (computed, not hardcoded; replaces the stale "use `nrow(ice)` inline" bullet). Checked by screenshot: fits. Reads local `data/mendota_ice.csv`. Original plan: Very simple YAML. Markdown: headings, lists, bold, **blank lines matter**. Code: code chunks, **setup chunk** (teach `#\| message: false` / `include: false` here only), **inline R**, and the **render-runs-in-a-fresh-session** gotcha (demo: create object in console, use it in doc, render fails). Open with the Mendota/beer hook. |
| 3 | Render & publish | `03_publish.qmd` | Yes | **First draft 2026-11-08 (13 slides incl. title).** Covers: two ways to share; `report_files/`; `embed-resources: true` (first nested YAML); brief `--to docx`/`--to typst` slide; free plan = public + listed on profile; publish (renders locally, uploads output); first-time device-code authorization; title set at first publish; republish via "Publish update to:" menu (not Y/n — Connect Cloud provider has no `publishRecord`, verified in quarto.js 1.11.9) and `_publish.yml`; Your turn adds `max(ice$ice_days)` sentence and republishes. **Deliberately no Git commit** (John: should ignore `*.html` first; not spending time on it now). Verified: single-file HTML render creates no `.quarto/`, but `--to docx`/`--to typst` render **does** create `.quarto/` → handle in a later `.gitignore` discussion. **Windows risk:** Quarto's interactive prompts may misbehave in Git Bash (mintty); test publish on Windows during the setup dry run. Original plan: Render locally to a single self-contained HTML (`embed-resources: true`); publish to Connect Cloud. **First publish includes the one-time Connect Cloud authorization, done live** (not in setup). Possibly show switching `format:` (docx/typst) as a one-line change. Good moment to add `/.quarto/` to students' `.gitignore` (GitHub's R template lacks it). |
| 4 | Slide decks (revealjs) | `04_slides.qmd` | Yes (~10 min, fixed budget) | **Drafted session 4 (9 slides incl. title); in book chapters; not yet reviewed by John.** `engine: knitr`, no executed chunks. Verified by applying the steps to a simulated student `slides.qmd`: figure fills its own slide after the split, `. . .` shows the averages first, notes render. Optional publish slide kept (John). Slide 1 bullet: "Yes, this copies your code; the paper unit comes back to that" (Unit 5 now says "three files: report, slides, and paper"). Arc: "your report is almost a deck" → `cp report.qmd slides.qmd`, change `format:` to `revealjs`, render → each `##` is a slide, YAML makes the title slide (verified: setup chunk before the first `##` makes no extra slide) → decks hide code by default (**verified: revealjs default `echo: false`**, so no `execute:` needed) → too much on one slide (verified: figure shrinks to make room for the three inline sentences) → split with a new `## The numbers` heading (mention `---` for an untitled slide) → bullets + `. . .` pause → speaker notes `::: {.notes}` + `S` → Your turn → "Optional: publish your deck" (kept at John's request; also the first thing to cut for time; give it its own `title:` first, since report and slides currently share "Ice Cover on Lake Mendota" and Connect Cloud sets the title at first publish) → where we are. **Moved to "Advanced slide formatting" reference:** columns, figure sizing (`fig-width`/`fig-height`, `auto-stretch`), code on slides, themes/logo/footer, print to PDF (`E`), duplicate-slide builds, John's CSS. |
| 5 | Writing a paper | `05_paper.qmd` | Yes (~15 min) | **Drafted session 4 (14 slides incl. title); in book chapters; not yet reviewed by John.** Decision: **simple paper `.qmd`, not the manuscript project type** (John may switch his lab to simple papers too; possible later advanced chapter on manuscripts). Flow: what a paper needs → `cp report.qmd paper.qmd` (DRY tease) → paper YAML (`abstract: \|`, `format: docx`, `execute: echo: false`) → render to Word (Windows: close the docx in Word before re-rendering; untested) → `.bib` file (shortened entry on slide; `bibliography: refs.bib`) → citation style (`csl: https://www.zotero.org/styles/apa`; needs internet; offline → `csl: apa.csl`) → cite (`[@magnuson2026]` vs `@magnuson2026`; `## References` at end) → `fig-ice_days` label + `fig-cap` + `@fig-ice_days` → `tbl-periods` chunk (`group_by(half_century = floor(year / 50) * 50)` + `summarize(winters, mean_days)` + `knitr::kable()`; verified 114/102/100/81, n 44/50/50/27) → Your turn → check your paper (typos only WARN: `(magnuson?)`, `?@fig-ice_days`) → Word + PDF from one render (`typst: citeproc: true`; *trim candidate*, HTML comment in source) → where we are (last live unit; points to reference units). Uses `engine: knitr` (no executed chunks) so ```` ```{{r}} ```` displays. Rendered as deck (no warnings, dense slides checked by screenshot) and in the book. |
| — | Advanced markdown for reports | | Reference | Italics, inline code, numbered/nested lists, URL links, images, pipe tables, math, callouts. |
| — | Chunk options & tables | | Reference | `echo`, `warning`, `fig-cap`, `fig-width`, etc.; tables (tinytable recommended). Also running chunks interactively in RStudio (moved out of Unit 2): green ▶ or Ctrl/Cmd+Shift+Enter; handy for testing, but runs in the console session, so a report can work there and still fail to render; `quarto render` is the real test. |
| — | Advanced slide formatting | | Reference | John's CSS files (`slides_teaching.css`, `utilities.css`) and conventions. |
| — | YAML in depth | | Reference | Other YAML settings John uses for reports, decks, and papers. Where YAML lives: document header vs. folder (`_metadata.yml`) vs. project (`_quarto.yml`), and how they merge. Coordinate with DRY unit (also touches `_quarto.yml`). |
| — | DRY: reuse code across products | | Reference | `knitr::read_chunk()` approach in `dry.md`. Also Quarto projects/`_quarto.yml`, `freeze`. |
| — | Git with Quarto projects | | Reference (advanced) | **Requested by John (session 4).** What to ignore (`*.html`, `*_files/`, `/.quarto/`, `*.docx`/`*.pdf` outputs; GitHub's R template lacks `/.quarto/`), whether to commit rendered output and `_freeze/`, `_publish.yml` (commit it), committing students' `mendota_ice` work (deliberately skipped in Unit 3). Verified facts to use: single-file HTML render makes no `.quarto/`; `--to docx`/`--to typst` renders do. |
| — | Manuscript projects | | Reference (advanced; **maybe**) | John undecided. See "Decided (session 4)" below for the trade-offs and what to test first. |
| — | Appendices | | Reference | Cheatsheet. Possibly: websites/books, parameterized reports. (Prerequisites now live in `index.qmd`.) |

Rough live timing: Unit 1 ~5, Unit 2 ~20, Unit 3 ~10, Unit 4 ~10, Unit 5 ~15 → **~60 min**, with no slack. Trim candidates: Unit 4's publish slide, Unit 5's Word + PDF slide. **Unit order decided (session 4): slides before paper, no swap.** John's reason: a project's lifecycle is typically report → early findings presented at a conference (slides) → paper. Unit 4's wrap-up says this.

### Decided (session 4): simple paper, not the manuscript project type

Reasons: a manuscript project needs `_quarto.yml` (students' repos have none) and brings project behavior (render-all, freeze). Its reuse mechanism, `{{</* embed */>}}`, fixes figure size, theme, and caption in the source notebook, which breaks dry.md principles 1 and 4. Per the Quarto docs (not tested), any `.qmd`/`.ipynb` in the project folder becomes a manuscript "notebook", so `report.qmd`/`slides.qmd` next to the article would be swept in, and the template's freeze-on default can hide edits to `R/analysis.R`. Upside of manuscripts (for a possible advanced chapter): one render gives an HTML article site + docx/PDF/JATS/MECA, and the "Article Notebook" shows hidden code (would replace dry.md's `ref.label` appendix). If taught, use a paper-in-a-subfolder manuscript project with `read_chunk(here::here("R/analysis.R"))`. Untested: notebook sweeping, freeze staleness, whether the Article Notebook shows code filled by `read_chunk()`, publishing a manuscript to Connect Cloud.

## Setup (`index.qmd` "Before the workshop") — decisions

Assumes Git workshop setup (Git; **Git Bash on Windows**; GitHub account; SSH key). Commands in Terminal / Git Bash / RStudio terminal. Six steps:

1. **Install Quarto separately** from quarto.org (don't rely on RStudio's bundled copy). Reasons: bundled copy is not reliably on the terminal PATH (on John's Linux box it isn't: bundled 1.10.18 at `/usr/lib/rstudio/resources/app/bin/quarto/bin/quarto`, not on PATH; system 1.11.9 at `/opt/quarto` is); bundled version depends on RStudio release; RStudio uses the PATH copy if newer, so no conflict.
2. **`quarto --version` ≥ 1.9** (needed for `quarto publish posit-connect-cloud`). Troubleshooting: "command not found" → reinstall, new terminal; too old → `which quarto`, reinstall; `quarto check`.
3. **Connect Cloud account** at connect.posit.cloud, sign up with GitHub; free plan.
4. **GitHub repo `mendota_ice`** (public or private), with **`R` .gitignore template** (also gives first commit so clone has tracking).
5. **Clone via SSH** into `~/github` (their repos folder from the Git workshop); `ls -a` shows `.git` and `.gitignore`.
6. **Download the data and references** (data added 2026-11-08; `refs.bib` added session 4): copy-paste `mkdir data` + `curl -fsSL -o data/mendota_ice.csv <raw URL>` + `curl -fsSL -o refs.bib <raw URL>` (to repo root); verify with `head -3 data/mendota_ice.csv` and `head -1 refs.bib`. Raw `refs.bib` URL verified. curl ships with macOS, Windows 10/11, and Git Bash. John rejected a template repo (wants students to make their own repo). Reason for local data: the raw URL was too long for slide code.

Deliberately **not** in setup: Connect Cloud terminal authorization (done live), tidyverse (students already have it), RStudio project (`.Rproj`) — John teaches projects in his spring course and fall students may not use them yet.

### Paths / working directory (decided 2026-11-08)

- Live units keep `report.qmd` (and later decks/papers) at the **repo root** with plain relative paths (`read_csv("data/mendota_ice.csv")`). No `.Rproj`, no `_quarto.yml` in students' repos.
- Verified in Quarto 1.11.9: `quarto render` runs in the `.qmd`'s folder regardless of where it's invoked; it ignores `.Rproj`. A `.qmd` in a subfolder breaks relative paths. `_quarto.yml` with `project: execute-dir: project` sets the working dir to the project root (render only; RStudio's interactive chunks don't read it). RStudio's default runs chunks interactively from the document's folder.
- **TODO (DRY / YAML-in-depth reference units):** introduce `here::here()` (finds root via `.Rproj`, `.here`, or `.git` — not `_quarto.yml`; students' repos have `.git`) and Quarto projects (`_quarto.yml`, `execute-dir`, plus side effects: render-all, project YAML, `freeze`, whole-project inspection on publish). Optionally mention `.Rproj` there as complementary (controls the interactive session, not render).

**Untested — do before the workshop:** on a clean **Windows laptop in Git Bash**: setup steps 1–2 (old forum reports say Git Bash needed `quarto.cmd`; unknown if still true), step 6 (curl), and Unit 3's `quarto publish` (interactive Y/n and menu prompts may misbehave in mintty; fallback: PowerShell or RStudio's terminal). Also: John's own first-publish run-through to check the Unit 3 authorization slide against what students actually see. Added session 4: Unit 5's claim that Word on Windows locks an open `paper.docx` so re-rendering fails; Unit 4's `S` speaker view (pop-up blockers); what `quarto publish` prompts for when publishing a **second** document (`slides.qmd`) with an existing account (Unit 4's optional slide says only "just like the report").

## Running example: Lake Mendota ice cover

- Story: Lake Mendota days of ice cover are declining. Hook (for Unit 2): per the State Climatology Office, the frozen/open rule came from Birge and Juday asking whether they could row a case of beer from Picnic Point to Maple Bluff. SCO calls it oral tradition (attributed to Reid Bryson), so the slide frames it as "the story".
- Analyses stay **descriptive**: figure of `ice_days` by winter; inline numbers; period summary table.
- Period means (verified 2026-11-08, grouping on `year`): 114 → 102 → 100 → 81 (n = 44, 50, 50, 27) for 1855–1899, 1900–1949, 1950–1999, 2000–2026. The original plan for a fuller period table (SD, shortest, longest) was replaced in Unit 5 by a shorter half-century table with the same numbers. Records: shortest 21 days 2001-02 (also 44 days 2023-24); longest 161 days 1880-81.
- Units 2–3 show only figure + inline numbers (`mean_1800s`, `mean_recent`, `min`/`max` of `ice_days`); Unit 5 adds the table (half-century version, see Unit 5 row) for the `@tbl-` demo.
- Students work in their own `mendota_ice` repo (starts with `.gitignore`, `data/mendota_ice.csv`, and `refs.bib` from setup). By end of Unit 3 their `report.qmd` has: YAML (title, author, `date: today`, `format: html: embed-resources: true`), `setup` chunk (`message: false`), Background section + list, `ice_plot` chunk, `means` chunk, inline sentences (means, shortest, longest), plus `_publish.yml`. Unit 4 adds `slides.qmd` (copy of report, `format: revealjs`, `## The numbers` slide with bullets, a pause, notes; optionally its own title and a second `_publish.yml` entry). Unit 5 adds `paper.qmd` (copy of report with paper YAML, citation, `fig-ice_days`, `tbl-periods`, `## References`) → `paper.docx`. **Undecided:** where John's own demo/solution files live (e.g., a folder in book_quarto vs. a separate repo). Simulated student files for Units 3–5 existed only in the scratch dir (not saved).

### Data (done)

| File | Contents |
|---|---|
| `data_raw/ntl33_v14.csv` | Raw EDI download (2026-11-07), untouched. "v14" is EDI's entity name, **not** the package version (ver 40). |
| `data_raw/mak_mendota_ice.R` | Prep script: Mendota only, winters 1855-56 onward, columns `winter` ("1855-56"), `year` (year the winter **ends**), `ice_days`; `stopifnot()` checks; citation in header. |
| `data/mendota_ice.csv` | Clean data: 171 winters (1855-56 to 2025-26), no gaps/NAs. Verified against SCO records. |
| `refs.bib` | `@magnuson2026` (EDI ver 40, DOI 10.6073/pasta/6a95bee73799927cbafbf87393be7038). `@dataset` type; proper nouns brace-protected. Tested with citeproc + APA CSL. **Students download it** (setup step 6), so any entry added later goes to them too; neither book nor slides config uses it. |

- Raw EDI quirks handled: incomplete 1852-53/1853-54, missing 1854-55; mid-winter thaws make `duration` ≠ `ice_off - ice_on` (dates dropped).
- Students download the CSV before the workshop (setup step 6) from `https://raw.githubusercontent.com/jjcurtin/book_quarto/main/data/mendota_ice.csv` — works only if book_quarto stays **public** and `data/mendota_ice.csv` stays at that path on `main`. Reports read it with `read_csv("data/mendota_ice.csv")` (relative path; `report.qmd` sits at the repo root). The DRY unit can introduce `here::here()`.

## Publishing / build setup

- Same mechanism as book_git: no committed `_quarto.yml`; `publish.sh book|slides [file]` copies `_quarto_book.yml` or `_quarto_slides.yml` to `_quarto.yml`, publishes, then removes it and build output. (`slides_wide` is gone from this repo — not wanted.) Units must work as book chapters and standalone decks → **no `@sec-` cross-refs between units**.
- `_quarto_slides.yml` has `project: render: ["*.qmd"]`. Why: with a `_quarto.yml` present, `quarto publish` inspects the whole project, treats `.md` files as inputs, and expands `{{</* include */>}}` even inside code fences — `dry.md` line 116's example include broke publishing. Book config is unaffected (only `chapters:` are processed).
- `_quarto_book.yml` chapters: `index.qmd`, `01_intro.qmd`, `02_report.qmd`, `03_publish.qmd`, `04_slides.qmd`, `05_paper.qmd`. Add new units as they're written. Book render with Units 1–5 verified in a scratch copy.
- `.gitignore` now has `/.quarto/` and `**/*.quarto_ipynb`. Note `book_quarto.Rproj` is (presumably deliberately) git-ignored.
- **How `quarto publish posit-connect-cloud` works**: renders locally (same pipeline, your R/packages), then uploads only the output; Connect Cloud never runs code. (Publishing *from GitHub* in the Connect Cloud UI is different: it renders on Posit's servers.)
- **Content title gotcha (verified in quarto.js 1.11.9)**: the Connect Cloud title is sent **only when content is first created**, from YAML `title:` (else the file name). Updates never change it. A `#` heading is not the document title. → Every unit puts its title in YAML `title:` (book chapter title and deck title slide both work; verified). To rename existing content: rename in Connect Cloud UI, or delete it there **and** remove its record from `_publish.yml`, then republish (new URL).
- Mermaid chunks need `%%| echo: false` (both configs set `echo: true`, so the diagram source otherwise prints). Mermaid renders well on slides but small in the book.
- Pipe-table column widths: `: {tbl-colwidths="[20,30,50]"}` works.
- Authoring conventions (from book_git): unit title in YAML `title:`; one `##` per slide; long `---` separators; builds by slide duplication; `[term]{.uwred}`; `gap-*` spacers; `.hl` tables; `callout-wide` > `callout-important` "Your turn"/"Next up"; appendices in prose with `#sec-` labels.
- Teaching Quarto *in* Quarto: show unexecuted chunks with ```` ```{{r}} ```` (**verified** in book + deck, Unit 2); show inline R literally with `` `r knitr::inline_expr("x")` `` — works inside ```` ```markdown ```` fences too (knitr evaluates inline `r` even inside plain code fences, so a bare `` `r x` `` there would execute). Units needing real output (figure, numbers) have a hidden `include: false` setup chunk reading `here::here("data/mendota_ice.csv")`. Units with no executed code (04, 05) set `engine: knitr` in YAML so ```` ```{{r}} ```` and `knitr::inline_expr()` still work (verified with it set; not tested without it). Escape shortcodes as `{{</* include */>}}` (not yet verified).
- Visual check workflow used this session: render a copy in the scratch dir, screenshot slides with `google-chrome --headless=new --screenshot ... "file://.../01_intro.html#/<slide-id>"` (hash must be the slide id, not a number).

### Citations and PDF engines (verified session 4, Quarto 1.11.9)

- `csl:` can be a URL for docx, HTML, and LaTeX PDF (Pandoc citeproc fetches it at each render).
- **Typst** formats citations itself by default: a CSL URL errors (`unknown style`). A local `apa.csl` works, but the output differs from citeproc (`@dataset` becomes "[Computer software]", no sentence-casing of the title). `typst: citeproc: true` gives output identical to docx. The complexity is Typst-only.
- **LaTeX PDF** (`format: pdf`) uses citeproc by default; CSL URL works with no extra option. John has TinyTeX (2026); students may not (`quarto install tinytex` = large download + package fetches on first renders, plus Windows risk) → Typst for students, `pdf` fine for John's lab.
- Default docx template shows author but **not affiliations**; Typst shows them → affiliations go in "YAML in depth".
- Typos don't stop renders: unresolved crossref → `?@fig-x` + WARNING; unknown key → `(key?)` + `Citeproc: citation key not found`.
- `@fig-ice_days` (underscore after prefix) works in docx and Typst.

### CSS: pending decision

Three additions to slide_decks' `presentation.css` (2026-11-05) not yet in the teaching CSS:

| Addition | Recommendation |
|---|---|
| `.reveal sup { font-size: 0.8em !important; }` | Port to `slides_teaching.css` in **both** book_git and book_quarto. |
| `.reveal h2:empty { display: none; }` | Port (harmless). |
| UW crest `body::after` on the red bar | John's call — would duplicate `logo: uwlogo.png`. |

## Conventions

- **snake_case across the board** (objects, functions, files, folders, chunk labels, repo names → `mendota_ice`); hyphens only where required (`fig-`/`tbl-`/`sec-` prefixes, e.g., `fig-ice_days`).
- `dry.md` still uses hyphenated chunk labels → convert to snake_case (`@fig-ice_days`-style cross-refs now verified in docx and Typst).
- **Slide text: one idea per line** (John's edits in commit `0b55572`, see `01_intro.qmd`). John glances at a slide and lectures in his own words; multi-sentence lines force him to read them aloud.
  - Never put two or more sentences/ideas in one slide paragraph. Split them into bullets.
  - A short lead-in line stays as plain text, then bullets (e.g., "You use them together:" followed by three bullets).
  - A `[label]{.uwred}` line sits on its own line with its supporting bullets below; separate label groups with `gap-md`.
  - Keep the wording; just split it. Bullets can be full sentences or fragments.
  - Book-only prose (appendices, reference-only units) can stay as paragraphs.

## dry.md (done)

Teaching reference for the `read_chunk()` DRY workflow (structure, `params: product:` + `_setup.qmd` with `theme_set()`, per-product YAML sizing, compute/display split for tables, showing code, `#| file:` variant, freeze/caching, pitfalls, teaching notes). Verified in Quarto 1.11.9 except freeze/cache staleness advice and `cache.extra`.

## Housekeeping / state at end of session

- book_quarto: last commit `b6e1dd1` ("updates through unit 05", John, after session 4): HANDOFF update, `_freeze/02_report`, and `_publish.yml` records for decks 02–05. **Pushed** (`main` = `origin/main`). It changed no unit `.qmd` files, so John's review edits to Units 2–5 (if any) are not in the repo yet. `_freeze/` is committed (from `3ae6084`); book_git tracks no `_freeze/` files, presumably because its units execute no R code.
- **All five decks are published** on Connect Cloud; URLs are in `_publish.yml` and in the `index.qmd` deck-links table. Whether the book was republished with Units 2–5 is unknown (book publishing doesn't write to `_publish.yml`). The `refs.bib` setup line now works for students, since `main` is pushed.
- Session 5 (uncommitted): `index.qmd` landing page drafted after book_git's: intro paragraph, "How this book is organized" (Units 1–5 all live; a TODO comment to add reference units as they are written), deck-links table, setup (unchanged), then "How to use this book" at the end (follow along in `mendota_ice`; terminal-first; conventions; GitHub source link). No cheatsheet mention yet (it doesn't exist). Unit YAML titles made consistent (session 5): all five use short titles with **no "Quarto Workshop:" prefix** (removed from 01–02), because the YAML title is also the book chapter title and the prefix cluttered the book sidebar. John adds the "Quarto Workshop:" prefix by hand in Connect Cloud's web interface so the workshop decks are easy to identify there (Connect Cloud never updates titles on republish, so his renames stick).
- Optional: Unit 1 says "manuscript" in a general sense (objectives line 13, outputs list line 40). It's fine as is; change it to "paper" only if you want consistent wording.
- `_publish.yml` **fixed** (2026-11-08): John deleted the deck and the file, then republished. Lesson: an *empty* `_publish.yml` makes Quarto warn "Unexpcted format ... not writing to publish history" and silently skip recording (it must be a YAML list or absent). To drop a record, edit it out; to reset, delete the file — never leave it empty.
- book_git: YAML title fix for units `01_setup.qmd`–`08_branches.qmd` committed and pushed (`b707d34`). John is renaming those decks manually on Connect Cloud (URLs already shared, so no republish). A stray untracked `_quarto.yml` (leftover from `publish.sh`) was found and fixed by John in session 4.
- `index.qmd` book TOC shows only the top `##` heading, not "Before the workshop"/steps (same `##` pattern as book_git's index). Minor; not investigated.

## Next steps (John will direct)

1. **John:** review Units 2–5 (decks published and pushed in `b6e1dd1`; no content edits yet), review the new `index.qmd`, and republish the book.
2. Apply John's review edits to Units 2–5. Re-check live timing (~60 min, no slack) in a dry run.
3. Decide where John's demo/solution files live; save demo `report.qmd`, `slides.qmd`, and `paper.qmd` that match Units 2–5.
4. Draft the advanced "Git with Quarto projects" reference unit (see outline row).
5. ~~Fill in `index.qmd` landing page~~ (drafted session 5). Update its organization list when reference units are added; add a cheatsheet line once one exists.
6. Windows dry run (see Setup "Untested", including the session-4 additions).
7. Reference units: advanced slide formatting (now including the topics cut from Unit 4), YAML in depth (including affiliations), chunk options & tables (including the moved RStudio-chunks content), DRY (here::here, Quarto projects), cheatsheet. Decide whether to add a manuscript-projects chapter.
8. Decide CSS ports; convert `dry.md` labels to snake_case.
