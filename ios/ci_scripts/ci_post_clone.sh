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

echo "Copying Generated.xcconfig to root ios/Flutter..."
mkdir -p $CI_PRIMARY_REPOSITORY_PATH/ios/Flutter
cp $CI_PRIMARY_REPOSITORY_PATH/mobile-app/ios/Flutter/Generated.xcconfig $CI_PRIMARY_REPOSITORY_PATH/ios/Flutter/Generated.xcconfig

echo "Installing CocoaPods dependencies..."
cd $CI_PRIMARY_REPOSITORY_PATH/ios
pod install --repo-update

echo "=== ci_post_clone.sh completed successfully ==="
