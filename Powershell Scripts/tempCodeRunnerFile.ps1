# Script to return current IPv4 addresses on a Linux or MacOS host
$ipInfo = ifconfig | Select-String 'inet'
$ipInfo = [regex]::matches($ipInfo, "addr:\b(?:\d{1,3}\.){3}\d{1,3}\b") | ForEach-Object value
foreach ($ip in $ipInfo) {
    $ip.Replace('addr:', '')
}