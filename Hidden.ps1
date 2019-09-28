[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True,Position=1)] [String]$Dir
)

# Search for all hidden files changed in the last week
Get-ChildItem -Recurse $Dir -Force -ErrorAction SilentlyContinue |
  # if .mode contains the letter 'h', it is a hidden file
  Where-Object { ($_.mode -match "h") -and
    # get-date returns current date, then subtract 7 days
    ($_.LastWriteTime -gt (Get-Date).AddDays(-7))
  }
  