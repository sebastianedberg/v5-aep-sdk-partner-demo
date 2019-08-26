# Partner Mobile Accelerator - v5mobile - AEP SDK

This project is based on the the newly released Adobe Experience Platform SDK for Mobile and has been adapted to be easily integrated in the partner sandbox environment.

## Disclaimer

This project is solely to be seen as a demo app of the AEP SDK capabilities and accelerator and not a production ready implementation.

## AEP SDK

In this demo app you will be using the [Adobe Experience Platform SDK for iOS or Android](https://aep-sdks.gitbook.io/docs/). The SDK will support more platforms to come like React Native.

## Download SDK

The app does already include the latest version through [CocoaPods](https://cocoapods.org/) or [Gradle](https://gradle.org) but if you want to update the SDK feel free to do so. Be aware that updates might effect the code base. Please test it thoroughly.

* [Get the SDK](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk)
* [Community Forum](https://forums.adobe.com/community/experience-cloud/platform/core-services/mobile-service)

## Important Links
* [AEP SDKS](https://github.com/Adobe-Marketing-Cloud/acp-sdks)

Note that by default you should always use the library dependecies that your Launch environment configuration suggests you when clickig on **Install** under **Environments**.
1. Gradle
```
implementation 'com.adobe.marketing.mobile:campaign:1.+'
implementation 'com.adobe.marketing.mobile:target:1.+'
implementation 'com.adobe.marketing.mobile:analytics:1.+'
implementation 'com.adobe.marketing.mobile:userprofile:1.+'
implementation 'com.adobe.marketing.mobile:sdk-core:1.+'
```
2. iOS
```
pod 'ACPCampaign', '~> 1.0'
pod 'ACPTarget', '~> 2.1'
pod 'ACPAnalytics', '~> 2.0'
pod 'ACPUserProfile', '~> 2.0'
pod 'ACPCore', '~> 2.0'
```

## Requirements for Push and In-App messages

1. ACS 19.1 or higher
2. [Adobe Launch](https://launch.adobe.com)
3. [Adobe.IO Integration setup for Launch](https://console.adobe.io/integrations)
4. TechOps connect ACS instance to Launch with Adobe.io details
5. TechOps configure MCIAS endpoint (Experience Platform In App Service)
6. [AEP SDK Campaign](https://cocoapods.org/pods/ACPCampaign) only for iOS available. Android in development


## Installation

Have a look at the indiviual [iOS README](/ios/README.md) or [Android README](/android/README.md) for more steps.

### Setup Analytics

Create a new Reportsuite based on the Mobile Template and within the Reportsuite settings > Mobile Application Reporting enable App Reports and Location Tracking.

In addition you can also configure processing rules for the context data.
- [Context Data](https://marketing.adobe.com/resources/help/en_US/sc/implement/context_data_variables.html)

### Configure Launch

Create a new mobile property. Go to *Extensions* **>** Catalog and install Mobile Core, Profile, Analytics, Target, Campaign. Configure every extension and build your library. Under *Environments* click on the install button to get your config id.

* [Property Configuration](https://aep-sdks.gitbook.io/docs/getting-started/create-a-mobile-property)

Once the Launch API is publicly available I will update the below Postman Collection to let you auto-create the complete mobile property
* [Auto Create Property](/resources/launch-postman-package/mobile-launch-property.json)

### In-App Messages Configuration

In Launch you need to configure Data Elements and Rules besides the Campaign extension.

1. Data Elements
* camp-server - Data Element Type - Campaign Extension **>** Value: **Campaign Server**
* pkey - Data Element Type - Campaign Extension **>** Value: **PKey**
* mcid - Data Element Type - Experience Cloud ID
* id   - Data Element Type - Free Form **>** Value: **id**
* hashedId - Data Element Type - ContextData **>** Key: **hashedId**
* pushPlatform - Data Element Type - ContextData **>** Key: **pushPlatform**

2. Rules
* IAM-Tracking - Action **>** Send Postback **>** Value: **https://{%%camp-server%%}/r/?id={%%id%%}&mcid={%%mcid%%}**
* [Detailed setup guide](https://helpx.adobe.com/campaign/kb/configuring-app-sdk.html#Step3CreaterulesforInApptrackingpostback)

### Push Configuration

How to configure the mobile app channel in Adobe Campaign Standard and AEP SDK.

* [Configuring the Campaign Launch extension](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/adobe-campaign-standard-beta)
* [About push notifications](https://helpx.adobe.com/campaign/standard/channels/using/about-push-notifications.html)
* [Implementing Push on iOS](https://marketing.adobe.com/resources/help/en_US/mobile/ios/push_messaging.html)
* [Trouble Shooting](https://marketing.adobe.com/resources/help/en_US/mobile/ios/c_troubleshooting-push-messaging.html)

A major change from SDK 4 to 5 is that there are rules to collect PII in Launch now instead of coding some of the logic into the app.
* [Setup rules in Launch and ACS](https://helpx.adobe.com/campaign/kb/configuring-app-sdk.html)

## AEM CaaS

### Requirements
The AEM package was built on AEM 6.4.0 with sample content. It has no major dependencies in the code but if you run it with **-nosamplecontent** please make sure to look at some component dependencies. I used:
- core wcm components all 2.0.4
- core wcm components extension 1.0.0
- we-retail-all (3.0.0)

### Configure

1. Install the [AEM CaaS package](/resources/aem-package/com.adobe.partners.v5mobile-1.0.zip) on Author and replicate to Publish
2. Point the app to your AEM Publish instance and path to the API Data Endpoint (the app has already defaults to your local AEM instance)
3. Add a new Asset based on the Location Content Fragment Model and embed it into the existing API site under Sites **>** We.Retail **>** Api **>** Locations


### Alternative to AEM

If you want to demo the JSON feed into the app without AEM, just host the *locations.model.json* on your own webserver instance and change the app config accordingly


## Existing links to mobile app demos:

- [Good Swift Tutorial on Push Notifications](https://appcoda.com/push-notification-ios/)
- [Push Notifications Tutorial](https://www.raywenderlich.com/156966/push-notifications-tutorial-getting-started)
- [Push Error Codes](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW17)


## Resources

- [Partner Portal / Demo Hub](https://solutionpartners.adobe.com)
- [AEM CaaS package](/resources/aem-package/com.adobe.partners.v5mobile-1.0.zip)
- [Example CaaS data feed](/resources/example-caas-data/locations.model.json)
- [Postman collection for Launch v0.1](/resources/launch-postman-package/mobile-launch-property.json)

## Built With

* [XCode 10.1](https://developer.apple.com/xcode/) - iOS IDE
* [Android Studio 3.2.1](https://developer.android.com) - Android IDE
* [Atom](https://atom.io/) - Code IDE

## Contributing

Please give me feedback on any section of this app - code, documentation, bugs, ...

## Authors

* **Max Eiselsberger** - *Initial work* - [dangermouse007](https://github.com/dangermouse007)

## Acknowledgments

* Looking forward to your contributions
