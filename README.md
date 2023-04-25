# Zentro

Zentro is a mobile application that simplifies the food ordering process in Somaiya Campus and its vicinity. Zentro was developed to address the challenges of traditional food ordering methods, such as long queues and waiting times, which can be frustrating and time-consuming for the busy students and faculty members of Somaiya Campus. 

With Zentro, customers can browse through the menus of food vendors and place their orders for takeaway food with just a few taps on their mobile devices. The application provides real-time updates on the status of the orders, allowing customers to plan their schedules accordingly. Zentro is a solution that meets the needs and expectations of the modern user, offering a convenient and efficient way to order food and save valuable time and effort.


## Modules

### Splash Module
In this Module all my services required for the app is loaded, such as local storage serice (objectbox), firebase service, location service, etc...

![Screenshot_2023-04-09-15-47-29-46_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276580-ff78d01e-1b87-41e1-91e1-b1f97f24c775.jpg)


### Onboarding
A first time setup for new users...

![Screenshot_2023-04-09-15-48-00-82_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276565-7d89a1ce-2f39-4d4c-9529-03ba6c20e325.jpg)
![Screenshot_2023-04-09-15-48-04-74_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276567-870ee3b2-5157-4c0a-84fd-36c758927a5a.jpg)
![Screenshot_2023-04-09-15-48-08-57_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276570-7f59b347-a49e-4a0c-bd75-989d588ee5a2.jpg)
![Screenshot_2023-04-09-15-48-11-36_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276573-34f1cfdd-1b6c-4796-88d0-4b8b26625c98.jpg)
![Screenshot_2023-04-09-15-48-16-20_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276576-ff14a501-bd44-48d3-8c5c-0318a052f1b4.jpg)


### Login/Signup (Authentication)
The module is designed to provide authentication functionality for users to access a database. It offers a validation mechanism along with the ability to select a country code. 

The backend of this module utilizes the Firebase Authentication package to authenticate and validate the phone number and OTP. Additionally, the module includes an in-app validation mechanism to ensure that the input size of the phone number and OTP is correct, which enhances the speed of validation.

![Screenshot_2023-04-09-16-00-40-67_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276517-cfa4b99e-2cab-4318-b114-a91492a850d0.jpg)
![Screenshot_2023-04-09-16-00-24-96_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276518-19a543ab-68a6-48af-8646-366444e1fce6.jpg)
![Screenshot_2023-04-09-16-00-32-35_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276519-3b4e7237-69f5-4a62-9a5c-c4f3053731fa.jpg)


### New user Setup
This is a module designed for registering new users for a service. The registration process includes requesting the user to input their name and email address. After the user inputs their information, an email verification is sent to their device. The user must then click on the verification email sent to their email address to verify their email. Once the email is verified, the user can now navigate to the home page.

Name Input Screen Shots

![Screenshot_2023-04-09-16-00-57-39_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276678-26e1fb36-6f09-4753-b5ad-f7daf92f4a01.jpg)
![Screenshot_2023-04-09-16-01-10-01_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276679-f742960e-a797-4e8e-ade0-99c5669dab1b.jpg)

Email Input Screen Shots

![Screenshot_2023-04-09-16-01-28-24_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276674-43d967fa-2c98-47d9-b80a-865f7be76e29.jpg)
![Screenshot_2023-04-09-16-15-15-28_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232276675-7613dd75-b0ed-48cd-a808-1a8b548077d7.jpg)


Email Verification Screen Shots

![Screenshot_2023-04-09-16-38-18-56_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232277090-d79c318a-f100-4d4a-a150-e2f14c9adbfb.jpg)
![Screenshot_2023-04-09-16-38-36-83_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232277091-4bfa3abd-67e5-427b-91d4-7ccb54322467.jpg)


### HomeScreen
The homescreen module is a crucial module in the application, as it serves as the main entry point for users. This module comprises the user profile and a list of restaurants, which enables users to initiate the ordering process. Additionally, if the user has an active order, it is displayed on the homescreen.

![Screenshot_2023-04-09-16-19-41-63_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278127-f15e3338-add9-4f7b-bc4b-7b9dccd62511.jpg)
![Screenshot_2023-04-16-12-10-17-67_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232277730-ffae3716-47b6-4a36-87f9-66da170fcb10.jpg)


### User Profile
The user profile module is a critical module within the application, as it allows users to manage their account details. Within this module, users can view and update their personal details such as their name, email, and photo. Additionally, this module also displays the user's order history, including current and past orders, and their favorite restaurants. These are displayed in their respective cards, which make it easier for users to view them. Finally, this module provides an option for the user to log out from the device.

![Screenshot_2023-04-09-16-57-56-83_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278227-0d2cc7b8-1418-450e-b498-8ee2fcfacedb.jpg)
![Screenshot_2023-04-09-17-09-22-02_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278584-3ba8ea28-b35a-4a4e-a1fa-a076ea75796d.jpg)
![Screenshot_2023-04-09-17-09-37-51_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278718-bed3048d-e1bf-4fe0-a44f-e052f9848741.jpg)


### Restaurant Module
The restaurant module is an essential component of the application, as it serves as the starting point for all ordering processes. This module provides basic information about the restaurant, such as its name, short description, rating, and location. Additionally, the restaurant module includes a filtering mechanism that allows the user to filter the menu list, and the user can share the restaurant with friends and family.

The restaurant module retrieves data from the Firebase Firestore database for restaurant and menu details, while images are retrieved from Firebase Storage. To enhance performance, restaurant details are cached in local storage using ObjectBox when the user opens the restaurant for the first time, and images are cached in the user's device cache location using DefaultCacheManager for Flutter.

If a restaurant has multiple outlets in the same area, an outlet selector is displayed instead of the location.

![Screenshot_2023-04-09-17-00-23-32_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278977-0f2e0222-45ef-46ee-a4e3-da9b7301db20.jpg)
![Screenshot_2023-04-09-17-01-02-72_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278979-b514d23f-f169-48f9-9339-4584b7b9c280.jpg)
![Screenshot_2023-04-16-12-30-27-80_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232278975-c5cf269f-b7c1-4bc1-8b26-c00bbb756b8e.jpg)


### Ordering Module

#### Order Detail

![Screenshot_2023-04-09-17-01-08-26_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279444-387dbfe0-4848-4ec3-8c67-d13c9ea7f8ff.jpg)
![Screenshot_2023-04-09-17-01-12-13_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279459-c23e2f26-0bee-4dd4-b63e-50e679f62163.jpg)

#### Payement Screen

![Screenshot_2023-04-09-17-01-15-54_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279473-9e06b3cd-80a2-419c-8981-574f1108faa5.jpg)
![Screenshot_2023-04-09-17-01-48-35_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279487-a761f1e9-0c16-4c9f-9b7e-fd4d935ae04c.jpg)
![Screenshot_2023-04-09-17-01-59-61_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279629-aea2a4c3-747e-4661-8dfb-12be40325248.jpg)


#### Order Status

![Screenshot_2023-04-09-17-02-26-82_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279722-c406fb66-9af9-4681-b696-380395f4b478.jpg)
![Screenshot_2023-04-09-17-02-04-26_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279728-1e3a31ce-6c00-4857-a598-f86989e69484.jpg)


#### Order Finished

![Screenshot_2023-04-09-17-02-38-81_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279746-e2378ee3-0df1-43d1-aa39-31cfabc0400b.jpg)
![Screenshot_2023-04-09-17-08-30-95_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279749-54da836f-15f7-40d8-bf19-00562c0ea14b.jpg)
![Screenshot_2023-04-09-17-08-37-07_084fdf4f13c5371393d67d4c3d22a1bd](https://user-images.githubusercontent.com/22190833/232279755-2c9e9343-3239-4b78-976f-b4b03a8a4ed7.jpg)


## Getting Started

### FIRST TIME SETUP

1. The Application is built using flutter 3.7.0, if you have an older or 4.0.0 and above package then you will require the usage of FVM. 
   * I don't need FVM, I have the same or supported flutter version:
     ```
     flutter pug get
     ```
   * Follow the steps bellow to install FVM on your device:
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
   * In project run
     ```
     fvm flutter pub get
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
