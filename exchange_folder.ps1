#: Author: Vladimir Asanov
#: Let recursevly set smtp folder permissions.
#: Use in Exchange connection (session).

$target_mail = "user1@domain" #user whose mail you want to share.
$transferee = "user2@domain"
$a = (Get-MailboxFolderStatistics -identity $target_mail).folderpath


add-MailboxFolderPermission -Identity $target_mail -AccessRights FolderVisible,ReadItems -User $transferee -ErrorVariable My_error -SendNotificationToUser $true
if($My_error.count -gt 0) # sometimes you need to rerun the script when some permissions has been already added.
    Set-MailboxFolderPermission -Identity $target_mail -AccessRights FolderVisible,ReadItems -User $transferee

$a | ForEach-Object -Process {
    $b = $_ -replace "/" , "\"
    $b = $b -replace "^", ":"
    $identity = $target_mail + $b
    Write-Host $identity -ForegroundColor Yellow
    Add-MailboxFolderPermission -Identity $identity -AccessRights FolderVisible,ReadItems -User $transferee -ErrorVariable My_error
    if($My_error.count -gt 0)
        Set-MailboxFolderPermission -Identity $identity -AccessRights FolderVisible,ReadItems -User $transferee
 }