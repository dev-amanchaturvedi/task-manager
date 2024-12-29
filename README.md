# Flutter Project Setup Guide

This guide will help you set up and run the Flutter project on your local machine. Follow the steps below to get started.

## Prerequisites

Make sure you have the following installed:

1. **Flutter SDK**:  
   - Download the latest stable version of Flutter from [Flutter's official website](https://flutter.dev/docs/get-started/install).
   - Ensure that Flutter is added to your system's PATH variable.

2. **Dart SDK**:  
   - Dart comes bundled with Flutter, so if you have Flutter installed, you should have Dart as well.

3. **IDE**:
   - Install an IDE that supports Flutter. The recommended IDEs are:
     - [Visual Studio Code](https://code.visualstudio.com/)
     - [Android Studio](https://developer.android.com/studio)
   - Install the Flutter and Dart plugins in your IDE for better development experience.

4. **Android Studio / Xcode**:
   - **Android**: For Android development, install [Android Studio](https://developer.android.com/studio) along with the Android SDK.
   - **iOS**: For iOS development, install Xcode (only on macOS).

## Setting Up the Project

### Step 1: Clone the repository

Clone the Flutter project repository to your local machine:

```bash
git clone <repository_url>
cd <project_folder>
```

### Step 2: Install Dependencies

Install all the dependencies used in the project:

```bash
flutter pub get
```

### Step 3:  Set up an Emulator or Device

Open Android Studio and set up an Android Emulator or connect a physical device.

### Step 4: Run the project

Now the project is ready to run:

```bash
flutter run

```