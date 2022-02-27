# iSpy

### Screenshots
<div style="float:left;margin:0 10px 10px 0" markdown="1">
 ![Splash Screen](/ScreenShots/1.png "Splash Screen")
 ![Main Screen](/ScreenShots/5.png "Main Screen")
 ![Attach letter dialog](/ScreenShots/2.png "Attach letter dialog")
 ![Competitor Screen](/ScreenShots/4.png "Competitor Screen")
 ![Competitor Screen 2](/ScreenShots/3.png "Competitor Screen 2")
</div>
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
 $ node index.js
 ```

** Note: The backend is not so stable and breaks a lot.(Neither have I followed any universal best practices) **
