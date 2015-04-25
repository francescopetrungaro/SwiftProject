# SwiftProject
This project provides a today extension, an embedded framework that I am using to share code between the app and the extension.
The embedded frameworks that uses and exposes a pod, for testing purpose I have selected a simple one called "TSCurrencyTextField" (Objective-C pod).

## What I want to do 
The goal of this project is to learn how use an iOS 8 app and extention in combination with dynamic frameworks and cocopoads.
I want to use the pod inside the embedded framework and also expose it outside. 


## Why?
Well, extensions are separate binaries and I would like to avoid source code duplications across multiple targets. 
When you have an app and an extension that share code and files from your main project the best way to work is create an embedded framework, available in iOS8. 

## How does it work? 
When you create a dynamic framework, Xcode generates an umbrella header filefor you that you can use to import other header files in the framework. For example, in this project, MyFramework has a header file named MyFramework.h.

I use 'use_frameworks!' in my podFile to generate a framework for each pod, in this case 'TSCurrencyTextField'.

The problems come when my App and my Today Extension want to use TSCurrencyTextField that seats inside my umbrella framework.
A compile time Xcode cannot find the framework.

#### Objective-C
Any Objective-C file created in your framework and that needs to be visible to the app or extension needs to be imported in the header file of MyFramework.

#### Swift
If you want to expose your swift classes, methods or variables you must add the 'public' keyword to them. 
In this way when your framework is built, the public classes, methods or variables will be accessible by your app or extension.

#### Objective-C Pod
Cocoapod generate a framwork for each Objective-C pod you specify in your pod file under MyFramework target. 
If you want that your app and the extension can see that framework for your pod you need to make sure to specify the correct FRAMEWORK_SEARCH_PATHS in the build settings of your app and extension.
 		 
You can do this adding: $(CONFIGURATION_BUILD_DIR)/Pods-FrameworkName (where FrameworkName is your Framework Target Name)

For this specific project is $(CONFIGURATION_BUILD_DIR)/Pods-MyFramework

## Branches

#### master
Based on everything I said above

#### develop
I have discovered something else using another pod, for this example I picked NZLabel.
Basically, I added this pod because it has public methods in the hedear. 
I also added a Bridging-Header to the app target. 

When I try to use this class everything is fine but a runtime the app crashes due to a specific error:

"dyld: Library not loaded: @rpath/NZLabel.framework/NZLabel"
"Reason: image not found"

## New Features To Add

1. Add Swift based pod to the framework
2. Add Objective-C classes to the frawework

## Suggestions???

I am open to any suggestion to update or improve it.



