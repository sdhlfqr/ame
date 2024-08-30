# Schedule .NET Framework tasks.
Get-ScheduledTask -TaskPath "\Microsoft\Windows\.NET Framework\" | Start-ScheduledTask

# Set PATH to .NET runtime directory to access ngen tool.
$env:PATH = [Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()

# Precompile .NET assemblies.
[AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object {
    $path = $_.Location

    if ($path)
    {
        $name = Split-Path $path -Leaf

        Write-Host -ForegroundColor Yellow "`r`nRunning ngen on '$name'"

        ngen.exe install $path /nologo
    }
}
