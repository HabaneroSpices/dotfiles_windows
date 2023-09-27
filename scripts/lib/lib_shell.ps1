$LASTLOGMSG=
$UPTODATE=0

function log($id, $msg)
{
  $LASTLOGMSG="$id"
  Write-Host "`t$id : $msg"
}
function abort($msg)
{
  Write-Host "`t$msg"
  exit 1
}
function success($msg)
{
  Write-Host "`tSuccess: $msg"
}
