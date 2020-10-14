$appID="<your APP ID> # Update with your app ID
$app_secret="<your APP secret" # Update with your app secret
$tenantId="<your tenant name or tenant ID>" # Update with your tenant name or tenant ID
$url = "https://login.windows.net/$tenantId/oauth2/token?api-version=1.0"
$url
$resourceAppIdUri = 'https://api.securitycenter.windows.com'
# Get authentication token to access o365 management API
function Get-Oauth
    {
        $body = @{grant_type="client_credentials";resource=$resourceAppIdUri;client_id=$appID;client_secret=$app_secret}
        $oauth = Invoke-RestMethod -Method Post -Uri $url -Body $body
        $oauth_time = (get-date).ToUniversalTime()
        $headers = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
		return $headers
    }
	
$headers=Get-Oauth
$headers
# Example query. Replace with your own query you want to run.
$body = @"
{
	"Query":"let url='^\\S+.login\\.php\\S+.cobrandid=90015$';
	let deletedEmails = EmailPostDeliveryEvents | distinct NetworkMessageId;
	EmailUrlInfo
	| where Url matches regex url
	| join EmailEvents on NetworkMessageId
	| where DeliveryAction == 'Delivered' and EmailDirection == 'Inbound' and NetworkMessageId !in (deletedEmails)
	| project Timestamp, NetworkMessageId, Url, SenderFromAddress, SenderIPv4, RecipientEmailAddress, Subject,DeliveryAction,PhishDetectionMethod, PhishFilterVerdict, FinalEmailActionPolicyGuid,EmailDirection"
}
"@
$body
$requestURI=$resourceAppIdUri+"/api/advancedhunting/run"
Invoke-WebRequest -Uri $requestURI -Headers $headers -Body $body -Method POST -ContentType 'application/json; charset=utf-8'
