# MedReminder

1) Clone or download project

2) Open Terminal, go to your project folder and inside folder "js":

    cd Documents / MyProjects / MedReminder / js, for example

3) Install npm:

    brew install node

    brew install watchman

    npm install -g react-native-cli

    npm install

4) Install module for push notifications

    npm install react-native-push-notification

    react-native link

5) Go to your main project folder

    cd ..

6) Install pods

   pod install

7) Go again to folder "js" inside your project folder and start npm with command:

    npm start

8) Open MedReminder.xcworkspace in XCode

9) Press Command + R

10) Enjoy)

During realization this project I had a lot of problems, because I've never used before React Native and Firebase.
And I decided to use Swift 3 because I've never wrote on Swift and it was a chance to try it. // I like big troubles :)

Mostly I had problems with connecting React Native elements with Native (send data, connection and etc.) and especially with JavaScript.
New syntax, css, handlers, using components in JS were the first time for me.
With Firebase I had less problems, because of good documentation.

In project you have to login with facebook.
All code on Swift 3 and one view CreateNewReminder and PushNotification are realized with React Native.
But PushNotifications doens't  work because I don't have time to pay my developer accout (sorry) and to get certificate 
and profile and I don't have oportunity to chect its.
App only for iPhones with iOS >= 10.

Thank you for new knowledge)


