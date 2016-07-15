
# Integration Walkthrough for iOS and Android

This guide provides step-by-step instructions to integrate Unity Ads 2.0 into an **Android Studio** or **iOS (Swift or Objc)** project.

###[To Get Started](#start)
  1. Create a Game Project in the [Unity Ads Dashboard](https://dashboard.unityads.unity3d.com)
  2. Download Unity Ads 2.0 for [iOS](https://github.com/Unity-Technologies/unity-ads-ios/releases) or [Android](https://github.com/Unity-Technologies/unity-ads-android/releases).

###[Android Integration](#android-header)
  1. [Import Unity Ads](#a1)
  2. [Add listener & callbacks](#a2)
  3. [Initialize Unity Ads](#a3)
  4. [Show an Ad](#a4)
  5. [Add rewarded integration](#a5)

###[iOS Integration](#ios-header)
  1. [Import Unity Ads](i1)
  2. [Add delegate & callbacks](i1)
  3. [Initialize Unity Ads](i1)
  4. [Show an Ad](i1)
  5. [Add rewarded integration](i1)
  
---
 
<a name="start"/>
# To Get Started

### Create a Game Project in the [Unity Ads Dashboard](https://dashboard.unityads.unity3d.com)

Log into the [Unity ads dashboard](https://dashboard.unityads.unity3d.com) using your [Unity3D account](https://unity3d.com).

Create a new game project, and enable test mode  
  1. Click new game, and name the project
  2. Select "Google Play Store", check the box "This game has not been published yet"
  3. Select "Not targeted for children under 13", unless your game *specifically* targets children.
  4. Click continue
  
> Please note that test mode can be toggled under (add screenshot)

At this point you should see a unique (7-digit) game ID that can be used to initialize Unity Ads in your project.

Download the [Unity Ads 2.0 for Android](https://github.com/Unity-Technologies/unity-ads-android/releases).

---

<a name="android-header"/>
#Android Integration


<a name="a1"/>
### 1. Import Unity Ads
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

<a name="a2"/>
### 2. Add Listener & Callbacks

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
    //Called when Unity Ads has a video available to show
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
    //Called when the Unity Ads detects an error
  }
}
```

<a name="a3"/>
### 3. Initialize Unity Ads

First, declare a **UnityAdsListener** in your activity.
```java
public class MainActivity extends AppCompatActivity {
  final private UnityAdsListener unityAdsListener = new UnityAdsListener();

  // ...
}
```

Then, initialize Unity Ads within the same scope as your **UnityAdsListener** declaration, using the game ID from your dashboard.

> Note: "YOUR_GAME_ID" is a 7-digit number from your game project in the [Unity Ads dashboard](https://dashboard.unityads.unity3d.com). (For example, "1091553")

```java
protected void onCreate(Bundle savedInstanceState) {
  UnityAds.initialize(this, "YOUR_GAME_ID", unityAdsListener);
}

```

<a name="a4"/>
### 4. Show an Ad
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

<a name="a5"/>
### 5. Reward the Player

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

<a name="i1"/>
### 1. Import Unity Ads
From the downloaded Unity Ads 2.0 folder, locate **UnityAds.framework**.

Drag-and-drop **UnityAds.framework** into your XCode project (and copy it).

<a name="i2"/>
### 2. Add Delegate & Callbacks
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
    //Called when Unity Ads is ready to show an ad
  }

  func unityAdsDidStart(placementId: String) {
    //Called when Uniy Ads begins playing a video
  }

  func unityAdsDidFinish(placementId: String, withFinishState state: UnityAdsFinishState) {
    //Called when a video completes
  }
  
  func unityAdsDidError(error: UnityAdsError, withMessage message: String) {
  }
}
```

<a name="i3"/>
### 3. Initialize Unity Ads
Initialize Unity Ads by calling `UnityAds.initialize("YOUR_GAME_ID", delegate: self)`

> Note: "YOUR_GAME_ID" is a 7-digit number from the [Unity Ads dashboard](https://dashboard.unityads.unity3d.com). (For example, "1091553")

```swift
 override func viewDidLoad() {
    super.viewDidLoad()
    UnityAds.initialize("YOUR_GAME_ID", delegate: self)
  }
```

<a name="i4"/>
### 4. Show an Ad
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

<a name="i5"/>
### 5. Reward the Player
The callback `unityAdsDidFinish(...)` is called when a video finishes.

Use `unityAdsDidFinish(...)` to reward the player if they watched the entire ad.

```swift
func unityAdsDidFinish(placementId: String, withFinishState state: UnityAdsFinishState) {
  if(state != .Skipped){
    //video was not skipped, reward the player!
    rewardUserForWatchingAnAd()
  }
}
```

Example project is available [here](). ADD A LINK HERE

---
