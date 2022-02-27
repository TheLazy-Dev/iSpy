# iSpy

### Screenshots

 <img src="/ScreenShots/1.png" width=540 height=350 alt="splash screen">
 <img src="/ScreenShots/5.png" width=270 height=350 alt="main screen">
 <img src="/ScreenShots/2.png" width=270 height=350 alt="attach letter dialog">
 <img src="/ScreenShots/4.png" width=270 height=350 alt="competitor screen">
 <img src="/ScreenShots/3.png" width=270 height=350 alt="competitor screen 2">
 
### Features
 - **iSpy** is a small game that allows you to compete with other players in the game.
 - It has basic interface for users to capture an image and send it to user with a letter of the user wants other person to search for.
 - Using socketIO and Flutter to communicate with the server.
 - The backend is also in the same folder

 ### To run and test the app
 ```
 $ cd to folder
 $ cd iSpy/ispy
 $ flutter clean 
 $ flutter pub get
 $ flutter run -d <Device Name>
 ```

 ### To run the server
 ```
 $ cd backend
 $ npm install
 $ node index.js
 ```

** Note: The backend is not so stable and breaks a lot.(Neither have I followed any universal best practices) **
