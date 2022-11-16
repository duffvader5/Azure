#Connect-AzureAD
$groups=Get-AzureADGroup -SearchString "example"
$resultsarray =@()
ForEach ($group in $groups){
    $members = Get-AzureADGroupMember -ObjectId $group.ObjectId -All $true 
    ForEach ($member in $members){
       $UserObject = new-object PSObject
       $UserObject | add-member  -membertype NoteProperty -name "Group Name" -Value $group.DisplayName
       $UserObject | add-member  -membertype NoteProperty -name "Member Name" -Value $member.DisplayName
       $UserObject | add-member  -membertype NoteProperty -name "ObjType" -Value $member.ObjectType
       $UserObject | add-member  -membertype NoteProperty -name "UserType" -Value $member.UserType
       $UserObject | add-member  -membertype NoteProperty -name "UserPrinicpalName" -Value $member.UserPrincipalName
       $resultsarray += $UserObject
    }
}
$resultsarray | Export-Csv -Encoding UTF8  -Delimiter ";" -Path "C:\Users\trsimon\OneDrive - Microsoft\Clients\WCG\Azure AD Roles\AADRoles_20220912\AADGroups-GG-TAPS.csv" -NoTypeInformation