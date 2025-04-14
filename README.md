# client-recipes-api
Client for recipes API (pet project)

**Check the internet access in the Manifest:**
`<uses-permission android:name="android.permission.INTERNET"/>`

**Change NDK version in the /android/app/build.gradle.kts:**
`android {
    ...
    ndkVersion = "29.0.13113456"`

**Warning!** 
Use "_http://10.0.2.2/api/v1_" URL for the Android emulator
Use "_http://0.0.0.0/api/v1_" URL for the iOs emulator
And for the production version or testing on the real devices use the real host 
or IP address of the local server (ifconfig | grep inet) "_http://192.168.3.182/api/v1_"