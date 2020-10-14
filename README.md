# Advanced-Hunting-API
Sample scripts to run hunting queries using Microsoft 365 Defender Advanced Hunting API.

## General info
Scripts in this repository are PoC samples that leverage Advanced Hunting API. They don't consitute complete solution.

## Deployment
You need to register Azure AD app to use the Advanced Hunting API.
API Permissions required for the app are described in this [article.](https://docs.microsoft.com/en-us/microsoft-365/security/mtp/api-advanced-hunting?view=o365-worldwide)

In the script update $appID, $app_secret and $tenantId variables according to your Azure AD configuration.
