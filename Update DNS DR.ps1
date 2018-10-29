#Change the file included to have the correct zone in it
#Change the file included to have correct PTR zone in it
$DNSservers= @(“Domain Controller”)
## Filepath to script and CSV files
$FP = “\\fileshare\Update DNS”
CD $FP
Foreach($DNSserver in $DNSservers)
{
 Import-CSV .\TestADelete.csv| foreach {
    dnscmd $DNSserver /RecordDelete $_.zone $_.hostname A $_.ip /f}
  Import-CSV .\TestACreate.csv | foreach {
    dnscmd $DNSserver /RecordAdd $_.zone $_.hostname A $_.ip}
  Import-CSV .\DNSPTRDelete.csv | foreach {
    dnscmd $DNSserver /RecordDelete $_.reversezone $_.lowip PTR $_.fqdn /f}
  Import-CSV .\DNSPTRCreate.csv | foreach {
    dnscmd $DNSserver /RecordAdd $_.reversezone $_.lowip PTR $_.fqdn}
}