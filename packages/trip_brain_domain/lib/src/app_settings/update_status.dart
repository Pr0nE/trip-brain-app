enum UpdateStatus { noUpdates, mandatoryUpdate, optionalUpdate }

abstract class UpdateStatusFetcher {
  Future<UpdateStatus> getAppUpdateStatus();
}
