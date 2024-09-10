# Appcircle Sauce Labs Saucectl component

Automate the execution of UI tests for Android and iOS applications using Saucectl by Sauce Labs.

## Input Variables

### Required

- `AC_SL_CONFIG_PATH`: Path to the Sauce Labs configuration file. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--config) documentation for the option detail.
- `AC_SL_USERNAME`: Sauce Labs username.
- `AC_SL_ACCESS_KEY`: Sauce Labs access key.
- `AC_RUN_ONLY_VIA_CONFIG`: Whether to run only using the configuration file. If you select this field as `true`, you will not need to fill in the following options.
- `AC_SL_REGION`: Specifies the Sauce Labs data center through which tests will run. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--region) documentation for the option detail.

### Optional

- `AC_SL_APP_PATH`: Path to the main application file that will be tested. This should be the location of the app (APK for Android or IPA for iOS) within the Sauce Labs environment or your build process. If not provided, app will be used as default in `config.yml`.
- `AC_SL_TEST_APP_PATH`: Path to the test application file, which contains the test code to be run against the main app. This is usually a separate test APK for Android or an additional test bundle for iOS. If not provided, app will be used as default in `config.yml`.
- `AC_SL_SELECT_SUITE`: Specifies a test suite to execute by name rather than all suites defined in the config file. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--select-suite) documentation for the option detail.
- `AC_SL_ARTIFACT_CLEANUP`: Clear the artifacts directory before downloading new test data. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--artifactscleanup) documentation for the option detail.
- `AC_SL_DOWNLOAD_DIR`: Specifies the path to the folder location in which to download artifacts. Define this variable by taking your repository directory as the root, for example `./.sauce/artifacts`. A separate subdirectory is generated in this location for each suite for which artifacts are downloaded. Must be set in conjunction with `Sauce Labs Download Match` and `Sauce Labs When to Download Artifacts`. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--artifactsdownloaddirectory) documentation for the option detail.
- `AC_SL_DOWNLOAD_MATCH`: Specifies which artifacts to download based on whether they match the name or file type pattern provided. Supports the wildcard character *. Must be set in conjunction with `Sauce Labs Download Directory` and `Sauce Labs When to Download Artifacts`. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--artifactsdownloadwhen) documentation for the option detail.
- `AC_SL_WHEN_ARTIFACT_DOWNLOAD`: Criteria for downloading assets. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--artifactsdownloadwhen) documentation for the option detail.
- `AC_SL_ASYNC`: Launch tests without waiting for preceding test results. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--async) documentation for the option detail.
- `AC_SL_BUILD`: Associates the tests with a build to support easy filtering of related test results in the Sauce Labs UI. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--build) documentation for the option detail.
- `AC_SL_CCY`: Maximum tests to run concurrently. If the config defines more suites than the max, excess suites are queued and run in order as each suite completes. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--ccy) documentation for the option detail.
- `AC_SL_ENV`: An environment variable key value pair that may be referenced in the tests executed by this command. Expanded environment variables are supported. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--env) documentation for the option detail.
- `AC_SL_FAIL_FAST`: Stop suite execution after the first failure. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--fail-fast) documentation for the option detail.
- `AC_SL_RETRIES`: Number of times to rerun a failed test suite. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--retries) documentation for the option detail.
- `AC_SL_ROOT_DIR`: Specifies the project directory. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--root-dir) documentation for the option detail.
- `AC_SL_SAUCEIGNORE`: Specifies the path to the `.sauceignore` file. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--sauceignore) documentation for the option detail.
- `AC_SL_SHOW_CONSOLE_LOG`: Include the `console.log` contents in the output for all tests. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--show-console-log) documentation for the option detail.
- `AC_SL_TAGS`: Keywords that may help you distinguish the test in Sauce Labs, and also help you apply filters to easily isolate tests based on metrics that are meaningful to you. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--tags) documentation for the option detail.
- `AC_SL_TIMEOUT`: Global timeout that limits how long saucectl can run in total. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--timeout) documentation for the option detail.
- `AC_SL_TUNNEL_NAME`: Use a running Sauce Connect tunnel to test. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--tunnel-name) documentation for the option detail.
- `AC_SL_TUNNEL_OWNER`: The tunnel owner, if it is not the testing account. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--tunnel-owner) documentation for the option detail.
- `AC_SL_TUNNEL_TIMEOUT`: How long to wait for the specified tunnel to be ready. Check [saucectl](https://docs.saucelabs.com/dev/cli/saucectl/run/#--tunnel-timeout) documentation for the option detail.

## Relationship

Below workflow steps are related with this step and should be used as recommended.

### Required Steps

There is no required step that needs to be run beforehand for this step to work as expected.

- [Git Clone](https://docs.appcircle.io/workflows/common-workflow-steps/git-clone)
- [Android Build for UI Testing](https://docs.appcircle.io/workflows/android-specific-workflow-steps/android-build-for-ui-testing)

For ReactNative, JavaKotlin:

- [Android Build](https://docs.appcircle.io/workflows/android-specific-workflow-steps/android-build)

For Flutter:

- [Flutter Build for Android](https://docs.appcircle.io/workflows/flutter-specific-workflow-steps/flutter-build-for-android)


### Preceding Steps

There is no preceding step advised to be run beforehand for this step to work as expected.

### Following Steps

There are no subsequent steps advised to be run for this step to work as expected.

- [Export Build Artifact](https://docs.appcircle.io/workflows/common-workflow-steps/export-build-artifacts)
