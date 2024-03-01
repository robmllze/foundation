

import '../deploy_to_web_hosting.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> main() async {
  await deployToWebHosting(
    app: "admin_app",
    environment: ServiceEnvironmentType.PROD,
    deploymentSite: "admin-prod",
  );
}
