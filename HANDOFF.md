# Project Handoff — Intro to Quarto workshop (book_quarto)

Last updated: 2026-11-08 (end of second session). Read this and [dry.md](dry.md) before continuing.

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
| 2 | Quarto report | | Yes | Very simple YAML. Markdown: headings, lists, bold, **blank lines matter**. Code: code chunks, **setup chunk** (teach `#\| message: false` / `include: false` here only), **inline R**, and the **render-runs-in-a-fresh-session** gotcha (demo: create object in console, use it in doc, render fails). Open with the Mendota/beer hook. |
| 3 | Render & publish | | Yes | Render locally to a single self-contained HTML (`embed-resources: true`); publish to Connect Cloud. **First publish includes the one-time Connect Cloud authorization, done live** (not in setup). Possibly show switching `format:` (docx/typst) as a one-line change. Good moment to add `/.quarto/` to students' `.gitignore` (GitHub's R template lacks it). |
| 4 | Slide decks (revealjs) | | Yes | Slide breaks (`##`, `---`), presenter notes (`::: {.notes}`, speaker view `S`), incremental (`. . .`) vs duplicate-slide builds, columns, figure sizing/overflow, code on slides, `execute: echo: false`, theme/logo/footer, print to PDF; publish the deck. **Likely place to trim** for time. |
| 5 | Manuscripts/papers | | Yes (important) | **Approach still open — see below.** Core: citations (`refs.bib`, `@key`, CSL), cross-refs (`@fig-`, `@tbl-`), author/affiliation/abstract YAML, docx output. |
| — | Advanced markdown for reports | | Reference | Italics, inline code, numbered/nested lists, URL links, images, pipe tables, math, callouts. |
| — | Chunk options & tables | | Reference | `echo`, `warning`, `fig-cap`, `fig-width`, etc.; tables (tinytable recommended). |
| — | Advanced slide formatting | | Reference | John's CSS files (`slides_teaching.css`, `utilities.css`) and conventions. |
| — | YAML in depth | | Reference | Other YAML settings John uses for reports, decks, and papers. Where YAML lives: document header vs. folder (`_metadata.yml`) vs. project (`_quarto.yml`), and how they merge. Coordinate with DRY unit (also touches `_quarto.yml`). |
| — | DRY: reuse code across products | | Reference | `knitr::read_chunk()` approach in `dry.md`. Also Quarto projects/`_quarto.yml`, `freeze`. |
| — | Appendices | | Reference | Cheatsheet. Possibly: Git tie-in (what to ignore), websites/books, parameterized reports. (Prerequisites now live in `index.qmd`.) |

Rough live timing: Unit 1 ~5, Unit 2 ~20, Unit 3 ~10, Unit 4 ~15, Unit 5 ~15 → **~65 min vs. 60** — trim (most likely Unit 4) or move content to reference.

### Open: what to teach in the manuscript unit

Quarto's `manuscript` project type is built around `{{</* embed */>}}` from notebooks, which fixes figure size/formatting in the source notebook — the reason we rejected embed for DRY. Options: simple article `.qmd` (typst/docx; lowest overhead, `read_chunk()` stays in DRY unit) — Claude's recommendation; manuscript project with `read_chunk()` in `index.qmd`; apaquarto. Not yet decided.

## Setup (`index.qmd` "Before the workshop") — decisions

Assumes Git workshop setup (Git; **Git Bash on Windows**; GitHub account; SSH key). Commands in Terminal / Git Bash / RStudio terminal. Five steps:

1. **Install Quarto separately** from quarto.org (don't rely on RStudio's bundled copy). Reasons: bundled copy is not reliably on the terminal PATH (on John's Linux box it isn't: bundled 1.10.18 at `/usr/lib/rstudio/resources/app/bin/quarto/bin/quarto`, not on PATH; system 1.11.9 at `/opt/quarto` is); bundled version depends on RStudio release; RStudio uses the PATH copy if newer, so no conflict.
2. **`quarto --version` ≥ 1.9** (needed for `quarto publish posit-connect-cloud`). Troubleshooting: "command not found" → reinstall, new terminal; too old → `which quarto`, reinstall; `quarto check`.
3. **Connect Cloud account** at connect.posit.cloud, sign up with GitHub; free plan.
4. **GitHub repo `mendota_ice`** (public or private), with **`R` .gitignore template** (also gives first commit so clone has tracking).
5. **Clone via SSH** into `~/github` (their repos folder from the Git workshop); `ls -a` shows `.git` and `.gitignore`.

Deliberately **not** in setup: Connect Cloud terminal authorization (done live), tidyverse (students already have it).

**Untested — do before the workshop:** steps 1–2 on a clean **Windows laptop in Git Bash**. Old forum reports say Git Bash needed `quarto.cmd`; unknown if still true.

## Running example: Lake Mendota ice cover

- Story: Lake Mendota days of ice cover are declining. Hook (for Unit 2): per the State Climatology Office, the frozen/open rule came from Birge and Juday asking whether they could row a case of beer from Picnic Point to Maple Bluff.
- Analyses stay **descriptive**: figure of `ice_days` by winter; inline numbers; period summary table.
- Planned table: summary by period — 1855–1899, 1900–1949, 1950–1999, 2000–2026 — winters (n), mean, SD, shortest, longest. Preview means 114 → 102 → 99 → 85. Inline numbers from the same summary object. Optional records slide (shortest 21 days 2001-02, 44 days 2023-24; longest 161 days 1880-81).
- Live workshop shows only figure + inline numbers; the manuscript unit needs a ready-made table chunk for the `@tbl-` demo.
- Students work in their own `mendota_ice` repo (starts with only `.gitignore`). **Undecided:** where John's own demo/solution files live (e.g., a folder in book_quarto vs. a separate repo).

### Data (done)

| File | Contents |
|---|---|
| `data_raw/ntl33_v14.csv` | Raw EDI download (2026-11-07), untouched. "v14" is EDI's entity name, **not** the package version (ver 40). |
| `data_raw/mak_mendota_ice.R` | Prep script: Mendota only, winters 1855-56 onward, columns `winter` ("1855-56"), `year` (year the winter **ends**), `ice_days`; `stopifnot()` checks; citation in header. |
| `data/mendota_ice.csv` | Clean data: 171 winters (1855-56 to 2025-26), no gaps/NAs. Verified against SCO records. |
| `refs.bib` | `@magnuson2026` (EDI ver 40, DOI 10.6073/pasta/6a95bee73799927cbafbf87393be7038). `@dataset` type; proper nouns brace-protected. Tested with citeproc + APA CSL. |

- Raw EDI quirks handled: incomplete 1852-53/1853-54, missing 1854-55; mid-winter thaws make `duration` ≠ `ice_off - ice_on` (dates dropped).
- Students read the CSV from `https://raw.githubusercontent.com/jjcurtin/book_quarto/main/data/mendota_ice.csv` — works only if book_quarto is **public** and pushed. The DRY unit can switch to local `data/` + `here::here()`.

## Publishing / build setup

- Same mechanism as book_git: no committed `_quarto.yml`; `publish.sh book|slides [file]` copies `_quarto_book.yml` or `_quarto_slides.yml` to `_quarto.yml`, publishes, then removes it and build output. (`slides_wide` is gone from this repo — not wanted.) Units must work as book chapters and standalone decks → **no `@sec-` cross-refs between units**.
- `_quarto_slides.yml` has `project: render: ["*.qmd"]`. Why: with a `_quarto.yml` present, `quarto publish` inspects the whole project, treats `.md` files as inputs, and expands `{{</* include */>}}` even inside code fences — `dry.md` line 116's example include broke publishing. Book config is unaffected (only `chapters:` are processed).
- `_quarto_book.yml` chapters: `index.qmd`, `01_intro.qmd`. Add new units as they're written.
- `.gitignore` now has `/.quarto/` and `**/*.quarto_ipynb`. Note `book_quarto.Rproj` is (presumably deliberately) git-ignored.
- **How `quarto publish posit-connect-cloud` works**: renders locally (same pipeline, your R/packages), then uploads only the output; Connect Cloud never runs code. (Publishing *from GitHub* in the Connect Cloud UI is different: it renders on Posit's servers.)
- **Content title gotcha (verified in quarto.js 1.11.9)**: the Connect Cloud title is sent **only when content is first created**, from YAML `title:` (else the file name). Updates never change it. A `#` heading is not the document title. → Every unit puts its title in YAML `title:` (book chapter title and deck title slide both work; verified). To rename existing content: rename in Connect Cloud UI, or delete it there **and** remove its record from `_publish.yml`, then republish (new URL).
- Mermaid chunks need `%%| echo: false` (both configs set `echo: true`, so the diagram source otherwise prints). Mermaid renders well on slides but small in the book.
- Pipe-table column widths: `: {tbl-colwidths="[20,30,50]"}` works.
- Authoring conventions (from book_git): unit title in YAML `title:`; one `##` per slide; long `---` separators; builds by slide duplication; `[term]{.uwred}`; `gap-*` spacers; `.hl` tables; `callout-wide` > `callout-important` "Your turn"/"Next up"; appendices in prose with `#sec-` labels.
- Teaching Quarto *in* Quarto: show unexecuted chunks with ```` ```{{r}} ````; escape shortcodes as `{{</* include */>}}` (verify both before wide use).
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

## dry.md (done)

Teaching reference for the `read_chunk()` DRY workflow (structure, `params: product:` + `_setup.qmd` with `theme_set()`, per-product YAML sizing, compute/display split for tables, showing code, `#| file:` variant, freeze/caching, pitfalls, teaching notes). Verified in Quarto 1.11.9 except freeze/cache staleness advice and `cache.extra`.

## Housekeeping / state at end of session

- book_quarto: John committed `c78ae00` (intro unit, index setup, `.gitignore`, configs). **Uncommitted**: `01_intro.qmd` (YAML title fix), `HANDOFF.md`, `_publish.yml`.
- **`_publish.yml` is empty.** John deleted the old `01_intro` deck and its record, and republished (title now correct), but the new record wasn't saved. Next publish of `01_intro.qmd` will create a **duplicate** deck. Fix: recreate the record by hand from the deck's Connect Cloud URL (format below), or delete the new deck and publish again.
  ```yaml
  - source: 01_intro.qmd
    posit-connect-cloud:
      - id: <content-id>
        url: https://connect.posit.cloud/jjcurtin/content/<content-id>
  ```
- book_git: **uncommitted** YAML title fix for units `01_setup.qmd`–`08_branches.qmd` (verified book + deck renders). John is renaming those decks manually on Connect Cloud (URLs already shared, so no republish).
- `index.qmd` book TOC shows only the top `##` heading, not "Before the workshop"/steps (same `##` pattern as book_git's index). Minor; not investigated.

## Next steps (John will direct)

1. Fix `_publish.yml` (see above); commit book_quarto and book_git changes.
2. Draft Unit 2 (`02_report.qmd`) and the demo `report.qmd`; decide where John's demo files live.
3. Units 3–5; decide manuscript approach; trim plan for the ~65-min total.
4. Fill in `index.qmd` landing page (intro, organization, deck-links table).
5. Test setup steps 1–2 on clean Windows/Git Bash.
6. Decide CSS ports. Reference units (incl. YAML in depth), cheatsheet, `dry.md` snake_case labels.
