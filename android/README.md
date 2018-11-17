# Partner Mobile Accelerator - v5mobile - AEP SDK - Android

This project is based on the the newly released Adobe Experience Cloud Platform SDK for Mobile and has been adapted to be easily integrated in the partner sandbox environment.

## Disclaimer

This project is solely to be seen as a demo app of the v5 capabilities and accelerator and not a production ready implementation.

## SDK V5

In this demo app you will be using the [Adobe Experience Cloud Platform SDK for Android](https://aep-sdks.gitbook.io/docs/)

## Download SDK

The app does already include the latest version through [Gradle](https://gradle.org/) but if you want to update the SDK feel free to do so. Be aware that updates might effect the code base. Please test it thoroughly.

* [Get the SDK](https://aep-sdks.gitbook.io/docs/getting-started/get-the-sdk)
* [Community Forum](https://forums.adobe.com/community/experience-cloud/platform/core-services/mobile-service)

## Important Links
* [AEP SDKS](https://github.com/Adobe-Marketing-Cloud/acp-sdks)

## Installation

The very first thing to do is to update the launch config id in  *MainActivity.java* e.g. *launch-EN123456789a0a00a12ab345a678a9a012* in the app project. This file id will download your Launch configuration for Analytics, Target, Visitor ID Service. The next steps will help you to get your own config file.

### Setup Analytics

Create a new Reportsuite based on the Mobile Template and within the Reportsuite settings > Mobile Application Reporting enable App Reports and Location Tracking.

In addition you can also configure processing rules for the context data.
- [Context Data](https://marketing.adobe.com/resources/help/en_US/sc/implement/context_data_variables.html)

### Configure Launch

Create a new mobile property. Go to *Extensions* **>** Catalog and install Mobile Core, Profile, Analytics, Target, Campaign. Configure every extension and build your library. Under *Environments* click on the install button to get your config id.

* [Property Configuration](https://aep-sdks.gitbook.io/docs/getting-started/create-a-mobile-property)

Once the Launch API is publicly available I will update the below Postman Collection to let you auto-create the complete mobile property
* [Auto Create Property](../resources/launch-postman-package/mobile-launch-property.json)

## Built With

* [Android Studio 3.2.1](https://developer.android.com) - Android IDE

## Contributing

Please give me feedback on any section of this app - code, documentation, bugs, ...

## Versioning

Current version is 1.0

## Roadmap

- Reflect current api coverage in the app

## Authors

* **Max Eiselsberger** - *Initial work* - [dangermouse007](https://github.com/dangermouse007)

## Acknowledgments

* Looking forward to your contributions

