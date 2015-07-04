# SwiftProject
This sample project shows the architecture I use to create a swift project that has the App and the Today Extension, and most important that shares pods and common classes between them.
embedded framework that I am using to share code between

The embedded frameworks that uses and exposes few pods, for testing purpose I have selected two simple Objective-C pods and one swift.

## Goal of the Project 
The goal of this project is to learn how use dynamic frameworks and cocopoads with an iOS 8 App and a Today Extention.
When develop and iOS App many don't think about a well structured architecture before start coding, even for a small application just because it's easy in that way.
My approach shows how you should structure your project before the start when you have App and the Today Extension that shares pods and common classes.

In the project I use pods inside the embedded framework and also expose useful pods outside (to the App and the Today Extension) because I would need to use there too. 

## Why?
Well, extensions are separate binaries and I would like to avoid source code duplications across multiple targets. 
When you have an app and an extension that share pods and classes from your main project the best way to work is create an embedded framework, available in iOS 8. 
And because the framework, the app and the extension have to use few common pods, why not include them into the framework that will expose what's necessary.

## How does it work? 
When you create a dynamic framework, Xcode generates an umbrella header file for you that you can use to import other header files in the framework. 
For example, in this project, MyFramework has a header file named MyFramework.h.

I use 'use_frameworks!' in my podFile to generate a framework for each pod and include them in my framework.

#### Objective-C
Any Objective-C class in your framework and that needs to be visible to the App or the Extension needs to be imported in MyFramework.h.

#### Swift
If you want to expose your swift classes, methods or variables you must add the 'public' keyword to them. 
In this way when your framework is built, the public classes, methods or variables will be accessible by your app or extension.

#### Objective-C Pod
Cocoapod generate a framwork for each Objective-C pod you specify in your podfile. 
If you want that your App and the Extension see your pod you need to make sure to import it in MyFramework.h as a Framework.

If it doesn't work, and the your App and the extension cannot see the pod, then make sure to specify the correct FRAMEWORK_SEARCH_PATHS in the build settings of your app and extension.

You can do this adding: $(CONFIGURATION_BUILD_DIR)/Pods-FrameworkName (where FrameworkName is your Framework Target Name)
For this specific project is $(CONFIGURATION_BUILD_DIR)/Pods-MyFramework


## New Features To Add

1. Add Objective-C classes to the frawework

## Suggestions???

I am open to any suggestion to update or improve it.
If there is something wrong with the project or for any improvements, please open an issue and create a pull request or you can contact me on [twitter](https://twitter.com/petrungarof).

-------
License
=======

This code is distributed under the terms and conditions of the MIT license.

