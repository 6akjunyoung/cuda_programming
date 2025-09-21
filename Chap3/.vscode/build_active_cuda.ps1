param(
  [Parameter(Mandatory=$true)] [string]$Root,
  [Parameter(Mandatory=$true)] [string]$File
)

# 루트로 이동
Set-Location -Path $Root

# 현재 파일의 디렉터리를 루트 기준 상대경로로
$srcDir = Split-Path -Path $File -Parent
$rel = Resolve-Path -Path $srcDir -Relative

# 앞의 .\ 또는 ./, 혹은 슬래시/역슬래시 반복 제거
$rel = $rel -replace '^[.\\\/]+',''

# 출력 디렉터리: <root>\output\<상대경로>
$outDir = Join-Path $Root ("output\" + $rel)
if (-not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

# 출력 파일명: <파일이름>.exe
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($File)
$outExe = Join-Path $outDir ("{0}.exe" -f $baseName)

# NVCC 컴파일/링크 (MSVC 문자셋 UTF-8)
& nvcc $File -o $outExe -Xcompiler "/utf-8"
exit $LASTEXITCODE