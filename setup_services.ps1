param (
    [switch]$buildServices = $false
)

function get_latest_build_tag() {
    git describe --tags $(git rev-list --tags --max-count=1)
}

function fetch_service_build_url() {
    param( [string]$FetchRepoOwner, [string]$FetchRepoName, [string]$FetchBuildTag )

    $rawData = $(curl -s "https://api.github.com/repos/$FetchRepoOwner/$FetchRepoName/releases/tags/$FetchBuildTag")
    $buildData = $rawData | ConvertFrom-Json
    return $buildData.assets[0].browser_download_url
}

function download_latest_service_build() {
    param( [string]$serviceOwner, [string]$serviceName )

    $latestTag = $(get_latest_build_tag)
    $buildUrl = $(fetch_service_build_url $serviceOwner $serviceName $latestTag)

    Write-Host "Downloading $buildUrl"

    $buildArchiveName = "build.tar.gz"

    curl -L $buildUrl --output $buildArchiveName
    tar -xzf $buildArchiveName
    Remove-Item $buildArchiveName
}

if ($buildServices -eq $true) {
    Write-Host "The user selected to build services..."
}
else {
    Write-Host "The user selected to download services prebuilds..."
}

Set-Location .\master-server
if ($buildServices -eq $true) {
    Write-Host "Building service Ochii/cso2-master-server"
    npm i
    npx gulp build
}
else {
    Write-Host "Fetching service Ochii/cso2-master-server"
    download_latest_service_build Ochii cso2-master-server
    npm i --only=production
}
Set-Location ..\

Set-Location .\users-service
if ($buildServices -eq $true) {
    Write-Host "Building service Ochii/cso2-users-service"
    npm i
    npx gulp build
}
else {
    Write-Host "Fetching service Ochii/cso2-users-service"
    download_latest_service_build Ochii cso2-users-service
    npm i --only=production
}
Set-Location ..\

Set-Location .\inventory-service
if ($buildServices -eq $true) {
    Write-Host "Building service Ochii/cso2-inventory-service"
    npm i
    npx gulp build
}
else {
    Write-Host "Fetching service Ochii/cso2-inventory-service"
    download_latest_service_build Ochii cso2-inventory-service
    npm i --only=production
}
Set-Location ..\

Set-Location .\webapp
if ($buildServices -eq $true) {
    Write-Host "Building service Ochii/cso2-webapp"
    npm i
    npx gulp build
}
else {
    Write-Host "Fetching service Ochii/cso2-webapp"
    download_latest_service_build Ochii cso2-webapp
    npm i --only=production
}
Set-Location ..\

if ($buildServices -eq $true) {
    Write-Host "Built services successfully"
}
else {
    Write-Host "Fetched services successfully"
}
