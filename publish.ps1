# Publish the portfolio to the personal GitHub Pages repository.
# Requires Git and GitHub CLI ('gh'). Creates a PUBLIC repository.
# Does not change existing GitHub repositories.
$ErrorActionPreference = 'Stop'
$Owner = 'PaoloPangallo'
$Repo = 'paolopangallo.github.io'
$FullRepo = "$Owner/$Repo"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git is missing. Install Git for Windows first: https://git-scm.com/download/win'
}
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw 'GitHub CLI is missing. Install it first: https://cli.github.com/'
}

& gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Host 'GitHub authentication required. Follow the login prompts.' -ForegroundColor Cyan
    & gh auth login
    if ($LASTEXITCODE -ne 0) { throw 'GitHub login failed.' }
}

& gh repo view $FullRepo *> $null
if ($LASTEXITCODE -eq 0) {
    throw "Repository $FullRepo already exists. No files were overwritten. Use a manual Git review for updates."
}

Write-Host "Creating PUBLIC GitHub Pages repository $FullRepo" -ForegroundColor Yellow
& gh repo create $FullRepo --public --description 'AI and ML Engineering portfolio — Paolo Pangallo'
if ($LASTEXITCODE -ne 0) { throw 'Repository creation failed.' }

$WorkDir = Join-Path $env:TEMP ("paolo-pages-" + [guid]::NewGuid().ToString('N'))
try {
    & git clone "https://github.com/$FullRepo.git" $WorkDir
    if ($LASTEXITCODE -ne 0) { throw 'Could not clone the new repository.' }

    & git -C $WorkDir switch -C main
    if ($LASTEXITCODE -ne 0) { throw 'Could not select main branch.' }

    foreach ($Name in @('index.html','style.css','script.js','favicon.svg','.nojekyll')) {
        $Source = Join-Path $PSScriptRoot $Name
        if (-not (Test-Path -LiteralPath $Source)) { throw "Missing file: $Source" }
        Copy-Item -LiteralPath $Source -Destination (Join-Path $WorkDir $Name) -Force
    }
    & git -C $WorkDir add -A
    & git -C $WorkDir commit -m 'Launch personal AI engineering portfolio'
    if ($LASTEXITCODE -ne 0) { throw 'Git commit failed. Configure your Git name and email if needed.' }
    & git -C $WorkDir push -u origin main
    if ($LASTEXITCODE -ne 0) { throw 'Git push failed.' }

    Write-Host "`nFiles pushed to https://github.com/$FullRepo" -ForegroundColor Green
    Write-Host 'Enable GitHub Pages: Settings -> Pages -> Deploy from a branch -> main / (root) -> Save.'
    Write-Host "The website URL will be: https://$Repo/ after GitHub Pages finishes publishing."
}
finally {
    if (Test-Path -LiteralPath $WorkDir) { Remove-Item -LiteralPath $WorkDir -Force -Recurse }
}
