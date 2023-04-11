# Zentro

Project Description

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
   2. Create a `.env` file in `assets/` folder
   3. Insert your private and secret keys in the .env file using the keys `STRIPE_TEST_KEY` & `STRIPE_TEST_SECRET_KEY` respectively.
      ```
      STRIPE_TEST_KEY=<YOUR_PRIVATE_KEY>
      STRIPE_TEST_SECRET_KEY=<YOUR_SECRET_KEY>
      ```

## ScreenShots
