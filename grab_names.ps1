$events = Get-WinEvent -LogName OpenSSH/Operational -ErrorAction SilentlyContinue

foreach ($event in $events) {
    if ($event.Message -like "*invalid*") {
        # Extract username (assuming it's in the form 'user' or 'user@domain')
        if ($event.Message -match '(?<=user\s)(\w+(?:\@\w+)?)') {
            $username = $Matches[0]
        } else {
            $username = "Unknown"
        }

        # Extract IP address
        if ($event.Message -match '(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})') {
            $ipAddress = $Matches[1]
            
            # Output both username and IP address
            Write-Output "Username: $username, IP: $ipAddress"
        }
    }
}
