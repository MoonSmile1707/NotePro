# Shrinking Your Android App Size

<hr/>

Mobile devices are limited in many ways. Whether it's how much of a charge your battery can hold, the amount of storage you have left, or the speed of your internet connection to view more cat gifs. We need to keep this into consideration for our users to give them the absolute best mobile experience.

## Bigger is not better

When it comes to application size, bigger is not betterr. In fact, it's one of the key factors a user takes into mind when considering installing or uninstalling your application.

By shrinking our APK size, we can also improve how:

- Fast our app loads.
- Much memory out app uses.
- Much power our app consumes.
- And much more.

## APK Analyzer

The first ste to understanding what we can shrink within our Android applications is analyzing the APK.

### APK Analyzer

Integrated inside [Android Studio or usable from the command line](https://developer.android.com/studio/command-line/apkanalyzer.html), you can use `apkanalyzer` as a way to provide immediate insight into the composition of your APK. Using APK Analyzer will help you reduce the size of your APK by inspecting your DEX files and Android Resources.

### Viewing the APK from the top-down

There are fore main areas that contribute to our large APK size:

- **res** - This folder includes all the files under your Resources folder.
- **assemblies** - This folder includes all of the assemblies required for your application.
- **lib** - This foldr includes native libraries for the respective ABIs that your application supports.
- **classes.dex** - This file holds all of your application's byte code that is executed by DVM or ART.

### Inspecting the res folder

We can optimize our resources by removing unused resources, resizing individual resources to mobile sizes, converting drawable to webp/vectors, and much more.

**Note**: if you're using Xamarin.Forms, you're most likely setting your images to EmbeddedResource. Since this embeds the resource into the assembly uncompressed, this can add quite a bit to your assemblies size. It mighr be a better decision to set these items as Android resources as you can optimize these further.

### Removing Unused Resources

When developing a project and gettingto the point of release, it's very likely we'll have left over resources that aren't used within the application. Remove any unused resources as a first go-through.

[Google's R8 tooling](https://blog.xamarin.com/androids-d8-dexer-and-r8-shrinker/) will also remove unues resources it finds within your application at build time.

### Resizing and Optimizing Resources

Chances are, you have larger resources than you can actually display on a mobile phone in your project. These resources should be resized to a size closer to the largest device you plan to support while keeping in mind. [Android Screen Dinsities](https://developer.android.com/training/multiscreen/screendensities).

### Convert images to WebP

Simlar to the optimaization tip above, we can [convert our images to WebP](https://developer.android.com/studio/write/convert-webp), a file format similar to JPG that provides lossy compression alongside the transparency PNG offers. It's the best of both worlds.

**Before: res** - 11.5MB
**After: res** - 2.1MB
**Total Saved**: 9.4MB

### Use VectorDrawable when you can

Instead of creating multiple density-specific versions of an image, you can create one vector graphic. Vector graphics create an image using the XML which defines paths and colors.[Learn more about Vector Graphics](https://developer.android.com/training/multiscreen/screendensities#vector-graphics).

### Inspecting the assemblies folder

Second, the assemblies folder contribures towards a nice chunk of oyr APK size with **14.8MB**.

### Running the Mono Linker

The Mono Linker will remove any unused types and members within your assemblies based on a static analysis of your application.

Keep in mind that using this setting is very prone to running into Linker errors. You can learn more about [controlling the linker here](https://docs.microsoft.com/en-us/xamarin/cross-platform/deploy-test/linker)

**Before: assemblies** - 14.8MB
**After: assemblies** - 12.6MB
**Save:** - 2.2MB

### Android App Bundles Coming Soon

[Xamarin.Android](http://xamarin.android/) will soon support App Bundles to provide users with optimized APKs per their device specifications when downloading an app from the Google Play Store or various Android App Stores.

Alongside that, it would ony include ABIs the device supports. The final APK delivered to the user's device would contain the minimal APK required for the application to run on device.

### Inspecting the DEX file

Other than being **2.0MB** towards our APK size, the classes.dex file does not have much insight other than seeing a distribution of where methods are defined inside your application and third-party libraties. There will be many methods that will be stripped in a result of applying ProGuard or R8

Enough inspecting, let's start applying some techniques to improve our APK size.

### Using ProGuard / R8

Enabling ProGuard or R8 will remove any unused code from your APK.

In the future ProGuard will be replaced with Google's R8 tooling by default which backwards-compatible with existing ProGuard rules. See about R8, read [here](https://blog.xamarin.com/androids-d8-dexer-and-r8-shrinker/).

## Summary

Through various tecniques of shrinking our Android APK, we were able to take our package from 34.MB to 21.9MB in just a few minutes. That's a **36% decrease in APK size!**

<hr/>

Get more information at [here](https://devblogs.microsoft.com/xamarin/shrinking-android-app-size/).
