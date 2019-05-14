#!/bin/sh

#
# this script sets up the cso2 master server services
# it downloads or builds the required files and installs the required npm dependencies
# pass --build-services as an argument to the script to build the services yourself
#

set -e

get_latest_build_tag() {
    git describe --tags $(git rev-list --tags --max-count=1)
}

fetch_service_build_url() {
    FETCH_REPO_OWNER=$1
    FETCH_REPO_NAME=$2
    FETCH_BUILD_TAG=$3

    curl -s "https://api.github.com/repos/$FETCH_REPO_OWNER/$FETCH_REPO_NAME/releases/tags/$FETCH_BUILD_TAG" |
        grep "browser_download_url" |
        cut -d \: -f 2,3 |
        tr -d "\"\ "
}

download_latest_service_build() {
    SERVICE_NAME=$1
    SERVICE_OWNER=$2

    LAST_TAG=$(get_latest_build_tag)
    BUILD_URL=$(fetch_service_build_url $SERVICE_OWNER $SERVICE_NAME $LAST_TAG)
    echo "Downloading $BUILD_URL"

    curl -L $BUILD_URL | tar -xz
}

SHOULD_BUILD_SERVICES=0

for i in "$@"; do
    if [ $i == "--build-services" ]; then
        SHOULD_BUILD_SERVICES=1
        echo "The user selected to build services..."
    fi
done

if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "The user selected to download services prebuilds..."
fi

cd ./master-server
if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "Fetching service Ochii/cso2-master-server"
    download_latest_service_build cso2-master-server Ochii
    npm i --only=production
elif [ $SHOULD_BUILD_SERVICES == 1 ]; then
    echo "Building service Ochii/cso2-master-server"
    npm i
    npx gulp build
fi
cd ../

cd ./users-service
if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "Fetching service Ochii/cso2-users-service"
    download_latest_service_build cso2-users-service Ochii
    npm i --only=production
elif [ $SHOULD_BUILD_SERVICES == 1 ]; then
    echo "Building service Ochii/cso2-users-service"
    npm i
    npx gulp build
fi
cd ../

cd ./inventory-service
if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "Fetching service Ochii/cso2-inventory-service"
    download_latest_service_build cso2-inventory-service Ochii
    npm i --only=production
elif [ $SHOULD_BUILD_SERVICES == 1 ]; then
    echo "Building service Ochii/cso2-inventory-service"
    npm i
    npx gulp build
fi
cd ../

cd ./webapp
if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "Fetching service Ochii/cso2-webapp"
    download_latest_service_build cso2-webapp Ochii
    npm i --only=production
elif [ $SHOULD_BUILD_SERVICES == 1 ]; then
    echo "Building service Ochii/cso2-webapp"
    npm i
    npx gulp build
fi
cd ../

if [ $SHOULD_BUILD_SERVICES == 0 ]; then
    echo "Fetched services successfully"
elif [ $SHOULD_BUILD_SERVICES == 1 ]; then
    echo "Built services successfully"
fi
