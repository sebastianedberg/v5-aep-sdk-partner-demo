# Partner Mobile Accelerator - v5mobile - AEP SDK - iOS

This project is based on the the newly released Adobe Experience Platform SDK for Mobile and has been adapted to be easily integrated in the partner sandbox environment.

## Disclaimer

This project is solely to be seen as a demo app of the AEP SDK capabilities and accelerator and not a production ready implementation.

## AEP SDK

In this demo app you will be using the [Adobe Experience Platform SDK for iOS](https://aep-sdks.gitbook.io/docs/)

## Download SDK

The app does already include the latest version through [cocoapods](https://cocoapods.org/) but if you want to update the SDK feel free to do so. Be aware that updates might effect the code base. Please test it thoroughly.

* [Get the SDK](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk)
* [Community Forum](https://forums.adobe.com/community/experience-cloud/platform/core-services/mobile-service)

## Important Links
* [AEP SDKS](https://github.com/Adobe-Marketing-Cloud/acp-sdks)

## Installation

The very first thing to do is to update the launch config id in  *MainActivity.java* e.g. *launch-EN123456789a0a00a12ab345a678a9a012* in the app project. This file id will download your Launch configuration for Analytics, Target, Visitor ID Service. The next steps will help you to get your own config file.

### Push Configuration

Update the signing section under Project > General with your own account and bundle identifier. You can now generate the push certificates under the Apple Developer Program (https://developer.apple.com). Remember to generate a certifcate that contains development and prod in one and add the PEM cert to the Adobe Campaign AEP SDK mobile channel.

### Setup Analytics

Create a new Reportsuite based on the Mobile Template and within the Reportsuite settings > Mobile Application Reporting enable App Reports and Location Tracking.

In addition you can also configure processing rules for the context data.
- [Context Data](https://marketing.adobe.com/resources/help/en_US/sc/implement/context_data_variables.html)

### Configure Launch

Create a new mobile property. Go to *Extensions* **>** Catalog and install Mobile Core, Profile, Analytics, Target, Campaign. Configure every extension and build your library. Under *Environments* click on the install button to get your config id.

* [Property Configuration](https://aep-sdks.gitbook.io/docs/getting-started/create-a-mobile-property)

## Built With

* [Xcode 10.2.1](https://developer.apple.com) - Apple Xcode IDE

## Contributing

Please give me feedback on any section of this app - code, documentation, bugs, ...

## Authors

* **Max Eiselsberger** - *Initial work* - [dangermouse007](https://github.com/dangermouse007)

## Acknowledgments

* Looking forward to your contributions
