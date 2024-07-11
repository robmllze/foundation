# Foundation Template for Flutter

This repository serves as the foundation workspace for effective Flutter application development. It is an amalgamation of several repositories that are designed to work together to provide a comprehensive and scalable architecture for Flutter applications.

<!----------------------------------------------------------------------------->

## Setup

1. Install Dart/Flutter on your system.

2. Download and install the following extensions for Visual Studio Code:

- [xyz-styled-region](https://marketplace.visualstudio.com/items?itemName=robmllze.xyz-styled-region)
- [xyz-run-tasks](https://marketplace.visualstudio.com/items?itemName=robmllze.xyz-run-tasks)
- [xyz-run-script](https://marketplace.visualstudio.com/items?itemName=robmllze.xyz-run-script)

3. Proceed to download and set up Visual Studio Code, ensuring the `code` command is integrated into your system's `PATH`.

4. Navigate to the folder where you keep your projects.

```zsh
cd your_projects_folder
```

5. Run the following command to start a new project called `your_project_name` with the foundation. Change 'with_firebase' to 'with_local' if you don't want to use any cloud services, or 'with_aws' once AWS support is available:

```zsh
curl -o setup https://raw.githubusercontent.com/robmllze/foundation/main/setup.dart
dart setup -name your_project_name --nogit -services-branch with_firebase
```

6. Delete the setup file that was downloaded:

```zsh
rm setup # macOS/Linux
del setup # Windows
```

7. Open the workspace with Visual Studio Code manually or via the terminal:

```zsh
code your_projects_folder/my.code-workspace
```

8. Look at the example apps under `/apps~example/`. You can delete this folder or rename it to `/apps/` so that the example apps are included in the workspace.

9. Create your own apps under `/apps/` and add them to the workspace by editing `my.code-workspace`.

10. The root of your project contains a file `sync_repo.zsh`, as well as the development layers `___generators`, `_data`, `_service_interfaces`, `_services`, and `_view`. Right-click on the file `sync_repo.zsh` and select `[xyz-run-script] Run`. This will pull the latest changes from their respective public repositories. You'll need to manually resolve all conflicts in Visual Studio Code to apply the changes. Be sure to remove the `.git` folders in each layer once done, to avoid accidentally pushing private changes to the public repositories.

<!----------------------------------------------------------------------------->

## Packages

This project uses several packages by the same author. Its important you understand how they work and how to use them effectively. You can find the packages and their documentation here:

- [XYZ Config](https://pub.dev/packages/xyz_config)
- [XYZ Device Info](https://pub.dev/packages/xyz_device_info)
- [XYZ Flutter Plus](https://pub.dev/packages/xyz_flutter_plus)
- [XYZ Gen Annotations](https://pub.dev/packages/xyz_gen_annotations)
- [XYZ Gen](https://pub.dev/packages/xyz_gen)
- [XYZ Pod](https://pub.dev/packages/xyz_pod)
- [XYZ Security](https://pub.dev/packages/xyz_security)
- [XYZ Utils](https://pub.dev/packages/xyz_utils)

<!----------------------------------------------------------------------------->

## License

This project is released under the MIT License. See [LICENSE](https://raw.githubusercontent.com/robmllze/foundation/main/LICENSE) for more information. You're free to use, modify, and distribute the software, provided you include the original copyright notice. No warranty is given, and the author(s) are not liable for damages.

<!----------------------------------------------------------------------------->

## Contact

**Author:** Robert Mollentze

**Email:** robmllze@gmail.com
