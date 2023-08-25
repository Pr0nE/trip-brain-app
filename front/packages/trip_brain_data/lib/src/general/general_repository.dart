import 'package:package_info_plus/package_info_plus.dart';
import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/exceptions/exception_mappers.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class GeneralRepository implements Pinger, UpdateStatusFetcher {
  GeneralRepository({
    required APIClient client,
  }) : client = client.generalClient;

  final GeneralClient client;

  @override
  Future<bool> ping() async {
    try {
      await client.ping(PingRequest());

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UpdateStatus> getAppUpdateStatus() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final response =
          await client.getCurrentVersion(GetCurrentVersionRequest());

      final latestVersion = AppVersion.fromString(response.version);
      final currentVersion = AppVersion.fromString(packageInfo.version);

      if (latestVersion.major > currentVersion.major) {
        return UpdateStatus.mandatoryUpdate;
      }
      if (latestVersion.minor > currentVersion.minor) {
        return UpdateStatus.optionalUpdate;
      }
      if (latestVersion.patch > currentVersion.patch) {
        return UpdateStatus.optionalUpdate;
      }

      return UpdateStatus.noUpdates;
    } catch (e) {
      throw e.toAppException();
    }
  }
}
