while ($True) {
  Write-Host $(Invoke-WebRequest -Uri "https://google.com" `
    -TimeoutSec 1).StatusCode
  Start-Sleep -Seconds 1
}
