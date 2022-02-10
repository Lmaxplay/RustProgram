param(
    [Parameter(Mandatory=$False)][System.String]$Main = 'main.cpp',
    [Parameter(Mandatory=$False)][System.Byte]$Wall = 0,
    [Parameter(Mandatory=$False)][System.Byte]$Compiler = 0,
    [Parameter(Mandatory=$False)][System.String]$O = "3",
    [Parameter(Mandatory=$False)][System.String]$IncludePath = "C:/Program Files (x86)/Windows Kits/10/Include/10.0.22000.0/"
)

$PSMinVersion = 7
$PSVersion = $PSVersionTable.PSVersion.Major
if($PSVersionTable.PSVersion.Major -lt 6) {
    $PSVersionFull = $PSVersionTable.PSVersion.Major.ToString() + "." + $PSVersionTable.PSVersion.Minor.ToString() + "." + $PSVersionTable.PSVersion.Revision.ToString()
} else {
    $PSVersionFull = $PSVersionTable.PSVersion.Major.ToString() + "." + $PSVersionTable.PSVersion.Minor.ToString() + "." + $PSVersionTable.PSVersion.Patch.ToString()
}

$OS = "Unknown OS"
if ($IsWindows) {
    $OS = "Windows"
} elseif ($IsMacOS) {
    $OS = "Mac OS"
} elseif ($IsLinux) {
    $OS = "Linux" + $Env:OS
}

# MSVC is C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx64/x64/cl
# Clang is C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/Llvm/x64/bin/clang++.exe

$PreviousColor = 'White'
$Host.UI.RawUI.ForegroundColor = $PreviousColor

function Write-Green {
    $Host.UI.RawUI.ForegroundColor = 'Green'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Yellow {
    $Host.UI.RawUI.ForegroundColor = 'Yellow'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Red {
    $Host.UI.RawUI.ForegroundColor = 'Red'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Purple {
    $Host.UI.RawUI.ForegroundColor = 'DarkMagenta'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Magenta {
    $Host.UI.RawUI.ForegroundColor = 'Magenta'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-White {
    $Host.UI.RawUI.ForegroundColor = 'White'
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Black {
    $Host.UI.RawUI.ForegroundColor = "Black"
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Cyan {
    $Host.UI.RawUI.ForegroundColor = "Cyan"
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

function Write-Blue {
    $Host.UI.RawUI.ForegroundColor = "Blue"
    Write-Output $args
    $Host.UI.RawUI.ForegroundColor = $PreviousColor # Restore the previous foreground color    
}

try {
    if ($PSVersion -lt 7) {
        Write-Red "This version of powershell is not supported, please use Powershell version $PSMinVersion or higher" "You are using Powershell version $PSVersionFull"
        exit
    }

    Write-Green 'Lmaxplay Rust build script v1.0.0' 'Licensed under the MIT License' 'Copyright 2022 Lmaxplay' ""

    #Write-Cyan "Running on PowerShell version $PSVersionFull" ""

    if($Wall -eq 0) {$WallOption = ''}
    if($Wall -eq 1) {$WallOption = '-Wall'}
    Write-Cyan 'Running compiler...'

    $CompilerTimer = [Diagnostics.Stopwatch]::StartNew()
    if ($IsWindows) {
        if ($Compiler -eq 0) {
            Write-Blue "Using RustC"
            rustc $OOption $WallOption 'src/main.rs' -o 'output/app.exe' -g
        } else {
            Write-Blue "Invalid compiler, Compiler number $Compiler is not configured"
        }
    } elseif ($IsLinux) {
        Write-Red "Linux is currently not supported, support will be added in version 2.0.0+"
    } elseif ($IsMacOS) {
        Write-Red "Mac OS is not supported"
        exit
    } else {
        Write-Red "Could not determine OS, thus no compilation executed"
    }
    $CompilerTimer.Stop()
    $CompileTime = $CompilerTimer.Elapsed
    Write-Cyan "Compile took $CompileTime"

    $CompileOut = $LASTEXITCODE
    if($CompileOut -ne 0) {
        Write-Red "exited with error code $CompileOut"
    } else {
        Write-Cyan "Compile completed succesfully"
    }
    Write-White ""

} catch {
    Write-Cyan "An error occured"
    Write-Red "$Error"
}