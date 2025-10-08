# Base64 Decoder powershell function
function Decode-Base64 {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    try {
        # Combine all arguments into a single string (in case user passed multiple words)
        $Base64String = ($Args -join '')

        # Auto-pad Base64 string if needed
        switch ($Base64String.Length % 4) {
            2 { $Base64String += '==' }
            3 { $Base64String += '=' }
            1 { throw "Invalid Base64 string length." }
        }

        $decodedBytes = [Convert]::FromBase64String($Base64String)
        $decodedString = [System.Text.Encoding]::UTF8.GetString($decodedBytes)
        Write-Output $decodedString
    }
    catch {
        Write-Error "Invalid Base64 string or decoding error: $_"
    }
}


  
# Base64 Encoder powershell function
function Encode-Base64 {
    param (
        [Parameter(Mandatory=$true)]
        [string]$String
    )
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($String)
        $encodedString = [Convert]::ToBase64String($bytes)
        return $encodedString
    }
    catch {
        Write-Error "Error encoding the string to Base64."
    }
}
