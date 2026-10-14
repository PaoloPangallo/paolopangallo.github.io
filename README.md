# Paolo Pangallo — Personal Portfolio

A responsive, colorful, dependency-free static portfolio for an AI / ML Engineering candidate.

## Files

- `index.html` — content, accessibility semantics, and portfolio projects
- `style.css` — layout, animations, breakpoints, and visual design
- `script.js` — mobile navigation, project filters, and scroll reveals
- `favicon.svg` — original portfolio icon
- `.nojekyll` — let GitHub Pages serve files without Jekyll processing

## Preview locally

Open `index.html` directly in a browser or run:

```bash
python -m http.server 8000
```

Then open http://localhost:8000.

## Publish to GitHub Pages

**Option A — Free project URL, using the existing profile repository:** The files can live in `docs/` inside `PaoloPangallo/PaoloPangallo`. Open that repository's **Settings → Pages**. Set **Source: Deploy from a branch**, **Branch: main**, **Folder: /docs**, then Save. After publishing, the project site URL is `https://paolopangallo.github.io/PaoloPangallo/` (GitHub will show the canonical deployed URL in Settings → Pages).

**Option B — Free short URL:** You may run `./publish.ps1` in PowerShell after installing Git and GitHub CLI; it creates the *public* repository and uploads site files, but you must still enable Pages in repository settings. Alternatively, manually create a new **public** repository named `paolopangallo.github.io`, upload these files to the repository root, and enable GitHub Pages on **main / (root)**. After publishing, the user site URL will be `https://paolopangallo.github.io/`.

**Option C — Personal `.io`:** Purchase a domain such as `paolopangallo.io` from a registrar and configure it as a custom domain in GitHub Pages, following GitHub's DNS and HTTPS instructions. Domain registration is not included in this project.

## Update content

All projects, descriptions, navigation, education, and LinkedIn links are plain HTML in `index.html`. Make sure public claims, degree status, and skill lists stay current. The GitHub avatar is sourced from the public GitHub profile.

No private keys, tracking pixels, analytics, or contact forms are included.
