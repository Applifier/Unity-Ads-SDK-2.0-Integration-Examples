
# Quickstart Guide for iOS and Android

This guide provides step-by-step instructions to integrate Unity Ads 2.0 into an **Android Studio** or **iOS (Swift or Objc)** project.

Download Unity Ads SDK 2.0 for iOS or Android [here](https://github.com/Unity-Technologies/unity-ads-android/releases).

( ADD LINK TO VIDEO TUTORIALS HERE )

For complete documentation please visit http://unityads.unity3d.com/help/monetization/integration-guide-android

###[Before we begin (iOS & Andoid)](#start)
  1. Create a Unity Ads Game Project
  2. Download the Unity Ads SDK 2.0

###[Android Integration](#android-header)
  1. Import Unity Ads SDK
  2. Add listener & callbacks
  3. Initialize SDK
  4. Show an Ad
  5. Add rewarded integration

###[iOS Integration](#ios-header)
  1. Import Unity Ads SDK
  2. Add delegate & callbacks
  3. Initialize SDK
  4. Show an Ad
  5. Add rewarded integration
  
---
 
<a name="start"/>
# Before we begin (iOS & Andoid)

### Create a Game Project in the [Unity ads dashboard](https://dashboard.unityads.unity3d.com)

Log into the [Unity ads dashboard](https://dashboard.unityads.unity3d.com) using your [Unity3D account](https://unity3d.com).

Create a new game project, and enable test mode  
  1. Click new game, and name the project
  2. Select "Google Play Store", check the box "This game has not been published yet"
  3. Select "Not targeted for children under 13", unless your game *specifically* targets children.
  4. Click continue
  
> Please note that test mode can be toggled under (add screenshot)

At this point you should see a unique (7-digit) game ID that can be used to initialize the SDK in your project.

Download the [Unity Ads 2.0 SDK](https://github.com/Unity-Technologies/unity-ads-android/releases).

---

<a name="android-header"/>
#Android Integration

  1. Import Unity Ads SDK
  2. Create listener & callbacks
  3. Initialize the SDK
  4. Show an ad
  5. Reward the player

### 1. Import Unity Ads SDK
From the downloaded Unity Ads 2.0 folder, locate **unity-ads.aar** and import using Android Studio's AAR import tool.

Or...
1. Copy **unity-ads.aar** to your project's */app/libs* folder. (Usually ~/AndroidStudioProjects/YOUR_PROJECT/app/libs)
2. In **build.gradle**, under `dependencies`, add `compile(name:'unity-ads', ext:'aar')`.  
```java
dependencies {
    // ...
    compile(name:'unity-ads', ext:'aar')
}
```
### 2. Add listener & callbacks

In **MainActivity.java** (or any activity that will show ads), add the Unity Ads headers.

```Java  
import com.unity3d.ads.IUnityAdsListener;
import com.unity3d.ads.UnityAds;
```
Then, create a **IUnityAdsListener** class that will listen for callbacks.

```java  
public class MainActivity extends AppCompatActivity {
    // ...
    
    private class UnityAdsListener implements IUnityAdsListener {
    
    }
}
```
Mouse over the class declaration to reveal a red lightbulb, then click "Implement methods" to automatically add the required callbacks:

```java 
private class UnityAdsListener implements IUnityAdsListener {
  @Override
  public void onUnityAdsReady(String s) {
    //Called when SDK has a video available to show
  }

  @Override
  public void onUnityAdsStart(String s) {
    //Called when a video begins playing
  }
  
  @Override
  public void onUnityAdsFinish(String s, UnityAds.FinishState finishState) {
    //Called when a video vinishes playing
  }
  
  @Override
  public void onUnityAdsError(UnityAds.UnityAdsError unityAdsError, String s) {
    //Called when the SDK detects an error
  }
}
```

### 3. Initialize the SDK

First, declare a **UnityAdsListener** in your activity.
```java
public class MainActivity extends AppCompatActivity {
  final private UnityAdsListener unityAdsListener = new UnityAdsListener();

  // ...
}
```

Then, initialize the SDK within the same scope as your **UnityAdsListener** declaration, using the game ID from your dashboard.

> Note: "YOUR_GAME_ID" is a 7-digit number from your game project in the [Unity Ads dashboard](https://dashboard.unityads.unity3d.com). (For example, "1091553")

```java
protected void onCreate(Bundle savedInstanceState) {
  UnityAds.initialize(this, "YOUR_GAME_ID", unityAdsListener);
}

```

### 4. Show an ad
In my example, I use a button to show an ad.

```java
public void buttonOnClick(View v) {
  if(UnityAds.isReady("rewardedVideo")){ //Make sure a video is available & the placement is valid.
    UnityAds.show(this, "rewardedVideo");
  }
}
```

> note: By default, leaving the *placement* option blank will show an ad with the default **"video"** placement. (5-second skip)
> Find more information on placements in our [docs](http://unityads.unity3d.com/help/monetization/placements).

### 5. Reward the player

In the UnityAdsListener class, there's a method, `onUnityAdsFinish`, that is called when a video finishes.

Use `onUnityAdsFinish` to reward the player if they watched the entire ad:
```java
private class UnityAdsListener implements IUnityAdsListener {

  //...

  @Override
  public void onUnityAdsFinish(String s, UnityAds.FinishState finishState) {
    if (finishState != UnityAds.FinishState.SKIPPED) {
      //video was not skipped, reward the player!
      rewardPlayer();
  }

  //...
  
  }
```

Example project is available [here](). ADD A LINK HERE

---

<a name="ios-header"/>
#iOS integration (Swift)

--- 

  1. Import Unity Ads SDK
  2. Add delegate & callback methods
  3. Initialize the SDK
  4. Show an ad
  5. Reward the player

### 1. Import Unity Ads SDK
From the downloaded Unity Ads 2.0 folder, locate **UnityAds.framework**.

Drag-and-drop **UnityAds.framework** into your XCode project (and copy it).

### 2. Add delegate & callbacks
In **ViewController.m** (or any ViewController that will show ads), import the UnityAds namespace.

```Swift
import UnityAds
```
Make the **ViewController** a **UnityAdsDelegate** and add the four `@required` callbacks.

```swift 

import UnityAds

class ViewController: UIViewController, UnityAdsDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func unityAdsReady(placementId: String) {
    //Called when the SDK is ready to show an ad
  }

  func unityAdsDidStart(placementId: String) {
    //Called when SDK begins playing a video
  }

  func unityAdsDidFinish(placementId: String, withFinishState state: UnityAdsFinishState) {
    //Called when a video completes
  }
  
  func unityAdsDidError(error: UnityAdsError, withMessage message: String) {
  }
}
```

### 3. Initialize the SDK
Initialize the SDK by calling `UnityAds.initialize("YOUR_GAME_ID", delegate: self)`

> Note: "YOUR_GAME_ID" is a 7-digit number from the [Unity Ads dashboard](https://dashboard.unityads.unity3d.com). (For example, "1091553")

```swift
 override func viewDidLoad() {
    super.viewDidLoad()
    UnityAds.initialize("YOUR_GAME_ID", delegate: self)
  }
```

### 4. Show an ad
In the example project, a button is used to show an ad.

```swift
@IBAction func AdButtonPressed() {
  if(UnityAds.isReady("rewardedVideo")){ //check that a video is ready & the placement is valid
    UnityAds.show(self, placementId: "rewardedVideo")
  }
}

```
> note: By default, leaving the *placement* option blank will show an ad with the default **"video"** placement. (5-second skip)
> Find more information on placements in our [docs](http://unityads.unity3d.com/help/monetization/placements).

### 5. Reward the player
The callback `unityAdsDidFinish(...)` is called when a video finishes.

Use `unityAdsDidFinish(...)` to reward the player if they watched the entire ad.

```java
func unityAdsDidFinish(placementId: String, withFinishState state: UnityAdsFinishState) {
  if(state != .Skipped){
    //video was not skipped, reward the player!
    rewardUserForWatchingAnAd()
  }
}
```

Example project is available [here](). ADD A LINK HERE

---
