
$TopIp = @("google.com","facebook.com")

$TopIp | ForEach-Object {
         
         $Ip = Test-NetConnection $_ | Select ComputerName,TraceRoute
         $TraceRoute = (Test-NetConnection $Ip.ComputerName -TraceRoute).TraceRoute

         Write-Host "Tracert IP  :$_ `n " -ForegroundColor Green
         $IPregex = "(?<LetterPart>\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b)"
         $result = [regex]::Matches($TraceRoute, $IPregex)
         $result | Select-String -Pattern $IPregex -AllMatches | ForEach-Object {$_.matches.groups[1].value}
         $date = Get-Date
         Write-Host "Tracert finish : $date `n `n "

} | FT