# Foundational Workspace for Flutter

This repository serves as a foundational workspace for effective Flutter application development. It is an amalgamation of several repositories that are designed to work together to provide a comprehensive and scalable architecture for Flutter applications.

## Setup

1. Install Dart/Flutter on your system.
2. Proceed to download and set up Visual Studio Code, ensuring the `code` command is integrated into your system's `PATH`.
3. Navigate to the directory where you keep your projects, for instance, using `cd ~/projects`. Avoid using directories on macOS that synchronize with cloud services, as this can lead to problems with Flutter.
4. On macOS or Linux, open the terminal, navigate to your projects folder then copy the following chunk into it and hit return:
```bash
curl -o setup https://raw.githubusercontent.com/robmllze/foundation/main/setup.dart
dart setup -name your_project_name --nogit
rm setup
```
5. On Windows, open PowerShell, navigate to your projects folder then copy the following chunk into it and hit enter:
```powershell
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/robmllze/foundation/main/setup.dart' -OutFile 'setup'
dart setup -name your_project_name --nogit
Remove-Item -Path 'setup'
```

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/foundation/main/LICENSE) for more information.

## Contact

**Author:** Robert Mollentze

**Email:** robmllze@gmail.com
