$ErrorActionPreference = "Stop"

$Source = Join-Path $PSScriptRoot "SKILL.md"
$TargetDir = Join-Path $HOME ".agents\skills\naver-blog-master"
$Target = Join-Path $TargetDir "SKILL.md"

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
Copy-Item -Path $Source -Destination $Target -Force

Write-Host ""
Write-Host "NAVER Blog Master skill installed."
Write-Host "Path: $Target"
Write-Host 'Call example: $naver-blog-master BLOG MASTER — 새 글 시작'
