#!/bin/sh

set -e

echo "=== Xcode Cloud: ci_post_clone.sh ==="

# Install Flutter SDK
FLUTTER_VERSION="3.41.6"
echo "Installing Flutter $FLUTTER_VERSION..."
cd $HOME
git clone https://github.com/flutter/flutter.git -b stable --depth 1 flutter_sdk
export PATH="$PATH:$HOME/flutter_sdk/bin"

echo "Precaching Flutter iOS artifacts..."
flutter precache --ios

echo "Flutter version:"
flutter --version

# Navigate to Flutter project directory
cd $CI_PRIMARY_REPOSITORY_PATH/mobile-app

echo "Running flutter pub get..."
flutter pub get

echo "Copying Flutter generated files to root ios..."
cp -r $CI_PRIMARY_REPOSITORY_PATH/mobile-app/ios/Flutter/ $CI_PRIMARY_REPOSITORY_PATH/ios/Flutter/

echo "Copying GeneratedPluginRegistrant to root ios/Runner..."
if [ -f "$CI_PRIMARY_REPOSITORY_PATH/mobile-app/ios/Runner/GeneratedPluginRegistrant.h" ]; then
    cp $CI_PRIMARY_REPOSITORY_PATH/mobile-app/ios/Runner/GeneratedPluginRegistrant.h $CI_PRIMARY_REPOSITORY_PATH/ios/Runner/GeneratedPluginRegistrant.h
    cp $CI_PRIMARY_REPOSITORY_PATH/mobile-app/ios/Runner/GeneratedPluginRegistrant.m $CI_PRIMARY_REPOSITORY_PATH/ios/Runner/GeneratedPluginRegistrant.m
fi

echo "Copying pubspec files to repo root for media_kit..."
cp $CI_PRIMARY_REPOSITORY_PATH/mobile-app/pubspec.yaml $CI_PRIMARY_REPOSITORY_PATH/pubspec.yaml
cp $CI_PRIMARY_REPOSITORY_PATH/mobile-app/pubspec.lock $CI_PRIMARY_REPOSITORY_PATH/pubspec.lock

echo "Installing CocoaPods dependencies..."
cd $CI_PRIMARY_REPOSITORY_PATH/ios
pod install --repo-update

echo "=== ci_post_clone.sh completed successfully ==="
