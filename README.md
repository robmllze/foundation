# Foundational Workspace for Flutter

This repository serves as a foundational workspace for effective Flutter application development. It is an amalgamation of several repositories that are designed to work together to provide a comprehensive and scalable architecture for Flutter applications.

## Setup

1. Install Dart/Flutter on your system.
2. Proceed to download and set up Visual Studio Code, ensuring the `code` command is integrated into your system's `PATH`.
3. Navigate to the directory where you keep your projects, for instance, using `cd ~/projects`. Avoid using directories on macOS that synchronize with cloud services, as this can lead to problems with Flutter.
4. Copy the entire block of commands below and paste it into your terminal, then press Enter or Return to clone and set up the workspace:

```bash
git clone -b main https://github.com/robmllze/foundation.git foundation
cd foundation
git clone -b main https://github.com/robmllze/___generators.git
git clone -b main https://github.com/robmllze/_data-foundation.git _data
git clone -b main https://github.com/robmllze/_service_interfaces-foundation.git _service_interfaces
git clone -b main https://github.com/robmllze/_view-foundation.git _view
git clone -b main https://github.com/robmllze/_services-foundation.git _services
dart pub get -C ___generators
dart pub get -C _data
dart pub get -C _service_interfaces
dart pub get -C _services
dart pub get -C _view
code my.code-workspace
```

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/foundation/main/LICENSE) for more information.

## Contact

**Author:** Robert Mollentze

**Email:** robmllze@gmail.com
