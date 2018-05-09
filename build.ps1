[CmdletBinding()]
Param(
    [switch]$CreateDraftFsx = $false,
    [string]$Script = "build.fsx",
    [string[]]$Arguments
)

$paketOutputDir = "./.paket/";
$paketExeOutput = $paketOutputDir + "paket.exe";
$paketVersion = "5.161.3";
$paketDependenciesFile = "paket.dependencies";

if (![System.IO.Directory]::Exists($paketOutputDir))
{
    [System.IO.Directory]::CreateDirectory($paketOutputDir);
}

if (![System.IO.File]::Exists($outputExe))
{
    $paketDownloadUrl = "https://github.com/fsprojects/Paket/releases/download/" + $paketVersion + "/paket.exe";
    Invoke-WebRequest $paketDownloadUrl -OutFile $paketExeOutput;
}

if (![System.IO.File]::Exists($paketDependenciesFile))
{
    & $paketExeOutput init

    [System.IO.File]::AppendAllText(
        $paketDependenciesFile, "nuget FAKE");

    & $paketExeOutput install
}

if ($CreateDraftFsx) 
{
    [System.IO.File]::WriteAllText(
        $Script,
@"
#r @"packages\\FAKE\\tools\\FakeLib.dll"
open Fake

let buildDir = "./build"

Target "Clean" (fun _ ->
    CleanDir buildDir
)

Target "Default" (fun _ ->
    trace "The operation has completed"
)

"Clean"
    ==> "Default"

RunTargetOrDefault "Default"
"@
    );
}

& "packages\FAKE\tools\Fake.exe" $Script $Arguments
exit $LASTEXITCODE