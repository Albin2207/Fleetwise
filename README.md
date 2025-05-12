# FleetWise App

## Description
FleetWise is a Flutter-based mobile application designed as a machine task. The app has been built using Flutter and follows clean state management practices.

> ⚠️ Important Note:  
> - API endpoints are not functional. All data (authentication, dashboard, etc.) is hardcoded in the app for demonstration purposes. 
> - Onboarding screen is not accessible via normal navigation flow since no API/state is fetched. You must manually set it as the home screen in `main.dart` if you want to access it.   
> - The "Skip" button on the onboarding/splash screen currently does not properly initialize authentication or navigation. This is a known issue and needs to be resolved in future updates.

---

## Table of Contents
- [Installation](#installation)
- [Libraries Used](#libraries-used)
- [Features](#features)
- [Running the App](#running-the-app)
- [Trade-offs and Known Issues](#trade-offs-and-known-issues)

---

## Installation

### Setup Steps

1. Clone the repository:
   git clone https://github.com/yourusername/fleetwise_app.git
Navigate to the project folder:
cd fleetwise_app

Get the dependencies:
flutter pub get

Run the app: 
flutter run

Libraries Used
Provider : For state management across the app.

Flutter Secure Storage: Used for securely storing sensitive data.

Shared Preferences: To store simple data in key-value pairs.

Image Picker: For selecting images from the device's gallery or camera.

Dio: A powerful HTTP client for making network requests (though, it's not currently used in this project since the API endpoints are not functional).

Features
Splash Screen: Displays the app logo and initializes authentication logic.

Dashboard Screen: The main screen displaying key data (currently hardcoded).

Login Screen: User authentication (mocked data as no API integration).

Navigation: there is only a single page so navigation is limited. to access the onboarding screen, has to manually code the navigation to go to that specific page.

Running the App
To run the app on a real device or emulator:

Ensure that the Flutter environment is set up correctly.

Use the command flutter run to start the app on your selected device.

Emulator/Real Device:
Connect your emulator or physical device via USB.

Use flutter devices to ensure the device is recognized.

Trade-offs and Assumptions
Mock Data: Since the API endpoints are not available, all data is hardcoded within the app itself. The authentication and data loading processes simulate actual operations without relying on network requests.

Limited Functionality: Some app features, like fetching live data, are not yet implemented due to missing backend API services. This also affects the navigation.

No API Integration: The app’s interactions are based purely on local state management. While the app uses the Dio package for API calls, these calls are not functional in the current version.

Conclusion
This is a prototype version of the FleetWise app with a focus on UI/UX and local state management.
