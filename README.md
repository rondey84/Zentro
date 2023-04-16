# Zentro

Zentro is a mobile application that simplifies the food ordering process in Somaiya Campus and its vicinity. Zentro was developed to address the challenges of traditional food ordering methods, such as long queues and waiting times, which can be frustrating and time-consuming for the busy students and faculty members of Somaiya Campus. 

With Zentro, customers can browse through the menus of food vendors and place their orders for takeaway food with just a few taps on their mobile devices. The application provides real-time updates on the status of the orders, allowing customers to plan their schedules accordingly. Zentro is a solution that meets the needs and expectations of the modern user, offering a convenient and efficient way to order food and save valuable time and effort.

## ScreenShots

### Splash Module
In this Module all my services required for the app is loaded, such as local storage serice (objectbox), firebase service, location service, etc...

![Screenshot_2023-04-09-15-47-29-46_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274728-176966a3-77d8-4b88-9d7c-2723ab57ec36.jpg)

### Onboarding
A setup for first time users...

![Screenshot_2023-04-09-15-48-00-82_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274806-eb3dab52-b5b0-48a6-b067-12847a559449.jpg)
![Screenshot_2023-04-09-15-48-04-74_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274821-2f3d7059-49b8-42d0-af2e-a411311e1e38.jpg)
![Screenshot_2023-04-09-15-48-08-57_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274826-2020fe43-f21a-47a9-a5d9-a341f893edb8.jpg)
![Screenshot_2023-04-09-15-48-11-36_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274831-e15cd9c6-b672-4f54-b32d-cf701c15dfe1.jpg)
![Screenshot_2023-04-09-15-48-16-20_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232274836-fdd4c985-4209-484e-a34d-33be2e18b501.jpg)

### Login/Signup (Authentication)
The module is designed to provide authentication functionality for users to access a database. It offers a validation mechanism along with the ability to select a country code. 

The backend of this module utilizes the Firebase Authentication package to authenticate and validate the phone number and OTP. Additionally, the module includes an in-app validation mechanism to ensure that the input size of the phone number and OTP is correct, which enhances the speed of validation.

![Screenshot_2023-04-09-16-00-24-96_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232275074-a913da38-d558-4b29-b97c-1e4abad4524a.jpg)
![Screenshot_2023-04-09-16-00-32-35_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232275069-32e0fe02-8519-443b-a458-b726fd938ccd.jpg)
![Screenshot_2023-04-09-16-00-40-67_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232275071-f27d83ae-c142-45e5-9e58-b173d1906193.jpg)

![Screenshot_2023-04-09-16-00-32-35_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276179-e78bcb95-cd2b-48ba-9196-75a7ac32ec31.jpg)
![Screenshot_2023-04-09-16-00-40-67_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276188-dff881f5-7eef-4480-a4bd-b97f56648d3c.jpg)
![Screenshot_2023-04-09-16-00-24-96_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276191-7c240949-be51-44a4-896f-7c1665bdc677.jpg)

![Screenshot_2023-04-09-16-00-32-35_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276450-16f5b0f0-f618-4b4b-ab47-5b218cb87c53.jpg)
![Screenshot_2023-04-09-16-00-40-67_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276451-bf7b4e9c-9a45-4c48-9364-781dd9fdb232.jpg)
![Screenshot_2023-04-09-16-00-24-96_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276452-e5451eae-655a-4d38-a00f-792bcca8072c.jpg)


## Getting Started

### FIRST TIME SETUP

1. **FVM USAGE**

   * *Read Me: https://fvm.app/docs/getting_started/installation*
   * Install and Activate FVM
     ```
     dart pub global activate fvm
     ```
   * **Configure VS Code**. Just create a folder inside the project called `.vscode` and then create a file called `settings.json` and add the following file:
     ```
     {
       "dart.flutterSdkPath": ".fvm/flutter_sdk",
       // Remove .fvm files from search
       "search.exclude": {
         "**/.fvm": true
       },
       // Remove from file watching
       "files.watcherExclude": {
         "**/.fvm": true
       }
     }
     ```
   * Install version 3.7.0 for the project
     ```
     fvm install 3.7.0
     ```
2. **BUILD RUNNER**

```
fvm flutter pub run build_runner build
```

3. **ENV Key**
   1. You will Need to create and setup a Stripe Account first.
   2. Create an `.env` file in `assets/` folder
   3. Insert your private and secret keys in the .env file using the keys `STRIPE_TEST_KEY` & `STRIPE_TEST_SECRET_KEY` respectively.
      ```
      STRIPE_TEST_KEY=<YOUR_PRIVATE_KEY>
      STRIPE_TEST_SECRET_KEY=<YOUR_SECRET_KEY>
      ```
