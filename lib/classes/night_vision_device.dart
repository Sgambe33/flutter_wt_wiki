class NightVisionDevice {
  String? commanderDevice;
  String? driverDevice;
  String? pilotDevice;
  String? sightDevice;
  String? targetingPodDevice;
  String? gunnerDevice;

  NightVisionDevice({
    this.commanderDevice,
    this.driverDevice,
    this.pilotDevice,
    this.sightDevice,
    this.targetingPodDevice,
    this.gunnerDevice,
  });

  factory NightVisionDevice.fromMap(Map<String, dynamic> map) {
    return NightVisionDevice(
      commanderDevice: map['commander_device'],
      driverDevice: map['driver_device'],
      pilotDevice: map['pilot_device'],
      sightDevice: map['sight_device'],
      targetingPodDevice: map['targeting_pod_device'],
      gunnerDevice: map['gunner_device'],
    );
  }

  @override
  String toString() {
    return 'NightVisionDevice(commander_device=$commanderDevice, driver_device=$driverDevice, pilot_device=$pilotDevice, sight_device=$sightDevice, targeting_pod_device=$targetingPodDevice, gunner_device=$gunnerDevice)';
  }

  bool isAllNull() {
    return commanderDevice == null && driverDevice == null && pilotDevice == null && sightDevice == null && targetingPodDevice == null && gunnerDevice == null;
  }
}
