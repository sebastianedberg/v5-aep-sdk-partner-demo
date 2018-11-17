# Partner Mobile Accelerator - v5mobile - AEP SDK - iOS

This project is based on the the newly released Adobe Experience Cloud Platform SDK for Mobile and has been adapted to be easily integrated in the partner sandbox environment.

## Disclaimer

This project is solely to be seen as a demo app of the v5 capabilities and accelerator and not a production ready implementation.

## SDK V5

In this demo app you will be using the [Adobe Experience Cloud Platform SDK for iOS](https://aep-sdks.gitbook.io/docs/). The SDK is also available for Android at the moment and more platforms to come like ReactJS Native.

## Download SDK

The app does already include the latest version through [CocoaPods](https://cocoapods.org/) but if you want to update the SDK feel free to do so. Be aware that updates might effect the code base. Please test it thoroughly.

* [Get the SDK](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk)
* [Community Forum](https://forums.adobe.com/community/experience-cloud/platform/core-services/mobile-service)

## Important Links
* [AEP SDKS](https://github.com/Adobe-Marketing-Cloud/acp-sdks)

## Requirements for Push and In-App messages

During Beta:
1. ACS 18.9 or higher
2. [Adobe Launch Integration](https://launch-integration.adobe.com)
3. [Adobe.IO Integration setup for Launch](https://console.adobe.io/integrations)
4. TechOps connect ACS instance to Launch with Adobe.io details
5. TechOps provision MCIAS endpoint (Marketing Cloud In App Service)
5. [AEP SDK Campaign Beta 1.0.2](https://cocoapods.org/pods/ACPCampaignBeta)

## Installation

The very first thing to do is to update the launch config id in  *AppDelegate.swift* e.g. *launch-EN123456789a0a00a12ab345a678a9a012* in the app project. This file id will download your Launch configuration for Analytics, Target, AudienceManager, Visitor ID Service, In-App Messages, Deeplinks, Postbacks. The next steps will help you to get your own config file.

### Setup Analytics

Create a new Reportsuite based on the Mobile Template and within the Reportsuite settings > Mobile Application Reporting enable App Reports and Location Tracking.

In addition you can also configure processing rules for the context data.
- [Context Data](https://marketing.adobe.com/resources/help/en_US/sc/implement/context_data_variables.html)

### Configure Launch

Create a new mobile property. Go to *Extensions* **>** Catalog and install Mobile Core, Profile, Analytics, Target, Campaign. Configure every extension and build your library. Under *Environments* click on the install button to get your config id.

* [Property Configuration](https://aep-sdks.gitbook.io/docs/getting-started/create-a-mobile-property)

Once the Launch API is publicly available I will update the below Postman Collection to let you auto-create the complete mobile property
* [Auto Create Property](../resources/launch-postman-package/mobile-launch-property.json)

### In-App Messages Configuration

In Launch you need to configure Data Elements and Rules besides the Campaign extension.

1. Data Elements
* camp-server - Data Element Type - Free Form **>** Value: **~state.com.adobe.module.configuration/campaign.server**
* pkey - Data Element Type - Free Form **>** Value: **~state.com.adobe.module.configuration/campaign.pkey**
* mcid - Data Element Type - Experience Cloud ID

2. Rules
* IAM-Tracking - Action **>** Send Postback **>** Value: **https://{%%camp-server%%}/r/?id={%%id%%}&mcid={%%mcid%%}**

* [Detailed setup guide](https://helpx.adobe.com/campaign/standard/administration/using/configuring-a-mobile-application-using-sdk-v5.html#setting-up-your-adobe-launch-application-in-adobe-campaign)

### Push Configuration

How to configure the mobile app channel in Adobe Campaign Standard and AEP SDK.

* [Configuring the Campaign Launch extension](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/adobe-campaign-standard-beta)
* [About push notifications](https://helpx.adobe.com/campaign/standard/channels/using/about-push-notifications.html)
* [Implementing Push on iOS](https://marketing.adobe.com/resources/help/en_US/mobile/ios/push_messaging.html)
* [Trouble Shooting](https://marketing.adobe.com/resources/help/en_US/mobile/ios/c_troubleshooting-push-messaging.html)

A major change from SDK 4 to 5 is that there are rules to collect PII in Launch now instead of coding some of the logic into the app.
* [Setup rules in Launch and ACS](https://helpx.adobe.com/campaign/standard/administration/using/configuring-a-mobile-application-using-sdk-v5.html)

## AEM CaaS

### Configure

1. Install the [AEM CaaS package](../resources/aem-package/com.adobe.partners.v5mobile-1.0.zip) on Author and replicate to Publish
2. Point the app to your AEM Publish instance and path to the API Data Endpoint (the app has already defaults to your local AEM instance)
3. Add a new Asset based on the Location Content Fragment Model and embed it into the existing API site under Sites **>** We.Retail **>** Api **>** Locations

* [AEM CaaS Video](https://videos)

### Alternative to AEM

If you want to demo the JSON feed into the app without AEM, just host the *locations.model.json* on your own webserver instance and change the app config accordingly


## Existing links to mobile app demos:

- [Good Swift Tutorial on Push Notifications](https://appcoda.com/push-notification-ios/)
- [Push Notifications Tutorial](https://www.raywenderlich.com/156966/push-notifications-tutorial-getting-started)
- [Push Error Codes](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW17)


## Resources

- [Partner Portal / Demo Hub](https://solutionpartners.adobe.com)
- [AEM CaaS package](../resources/aem-package/com.adobe.partners.v5mobile-1.0.zip)
- [Example CaaS data feed](../resources/example-caas-data/locations.model.json)
- [Postman collection for Launch v0.1](../resources/launch-postman-package/mobile-launch-property.json)

## Built With

* [XCode 10.1](https://developer.apple.com/xcode/) - iOS IDE
* [Atom](https://atom.io/) - Code IDE

## Contributing

Please give me feedback on any section of this app - code, documentation, bugs, ...

## Versioning

Current version is 1.2

## Roadmap

- Add app to app store
- Reflect current api coverage in the app
- Add AudienceManager extension

## Authors

* **Max Eiselsberger** - *Initial work* - [dangermouse007](https://github.com/dangermouse007)

## Acknowledgments

* Looking forward to your contributions
