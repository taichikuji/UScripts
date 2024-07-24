# Check and import the Active Directory module if not already imported
if (!(Get-Module -Name ActiveDirectory)) {
  Import-Module ActiveDirectory
  Clear-Host
}

# Infinite loop to display the menu until user exits
while ($true) {
  $menu = Read-Host -Prompt @"
Choose an option:
1. Modify computer data to match the M06 Practical Case exercise
2. Install Active Directory on Windows Server (Requires restart)
3. Import CSV
5. Exit
"@

  switch ($menu) {
      1 {
          # Modify computer name and network settings
          Rename-Computer -NewName "SERVER-PEREZ" -LocalCredential RemoteComputerAdminUser -Force
          New-NetIPAddress -InterfaceIndex 1 -IPAddress 192.168.1.105 -PrefixLength 24
          Set-DnsClientServerAddress -InterfaceIndex 11 -ServerAddresses "192.168.1.105"
      }
      2 {
          # Install Active Directory and restart the server
          Install-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature
          Import-Module ActiveDirectory
          Add-WindowsFeature AD-Domain-Services
          Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
          Install-ADDSForest -DomainName "PEREZ.local" -InstallDNS
          Restart-Computer -Force
      }
      3 {
          # Import users from CSV and configure Active Directory
          $csvLocation = Read-Host -Prompt "Enter the path of the CSV file (e.g., C:\Folder\File.csv)"
          $users = Import-Csv -Path $csvLocation -Encoding UTF8

          foreach ($user in $users) {
              $userAccount = $user.usuari
              $ou = $user.UO
              $group = $user.grup
              $path = "OU=$ou,DC=PEREZ,DC=local"
              $password = ConvertTo-SecureString -String "L@laL030" -AsPlainText -Force

              $parameters = @{
                  SamAccountName        = $user.usuari
                  UserPrincipalName     = $user.usuari
                  Name                  = $user.nom
                  DisplayName           = $user.nom
                  GivenName             = $user.usuari
                  Surname               = $user.cognoms
                  AccountPassword       = $password
                  ChangePasswordAtLogon = $false
                  Enabled               = $true
                  Path                  = $path
              }

              if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ou'")) {
                  # Create Organizational Unit if it does not exist
                  New-ADOrganizationalUnit -Name $ou -Path "DC=PEREZ,DC=local"
                  Write-Output "Organizational Unit '$ou' created."
              }

              if (-not (Get-ADGroup -Filter "Name -eq '$group'")) {
                  # Create group if it does not exist
                  New-ADGroup -Name $group -SamAccountName $group -GroupCategory Security -GroupScope Global -DisplayName $group -Path $path
                  Write-Output "Group '$group' created."
              }

              if (-not (Get-ADUser -Identity $userAccount)) {
                  # Create user and add to group
                  New-ADUser @parameters -PassThru | Add-ADGroupMember -Identity $group
                  Write-Output "User '$userAccount' created and added to group '$group'."
              }

              if ((Get-ADUser -Identity $userAccount -Properties MemberOf).MemberOf -like "*FACTURACIO*") {
                  # Disable account if user is part of FACTURACIO group
                  Disable-ADAccount -Identity $userAccount
                  Write-Output "User '$userAccount' disabled because they belong to FACTURACIO."
              }

              Write-Output "Completed! Check Active Directory for changes."
          }
      }
      5 { break }
      default { Write-Output "Invalid option. Please choose again." }
  }
}
