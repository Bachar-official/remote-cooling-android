enum ConditionerStatus { off, undefined, cold17, cold22, hot30, auto, fan }

enum ConditionerCommand {
  off,
  ping,
  set_200,
  set_201,
  set_202,
  set_100,
  set_101
}

Map<ConditionerStatus, ConditionerCommand> statusCommandDictionary = {
  ConditionerStatus.auto: ConditionerCommand.set_100,
  ConditionerStatus.fan: ConditionerCommand.set_101,
  ConditionerStatus.cold17: ConditionerCommand.set_200,
  ConditionerStatus.cold22: ConditionerCommand.set_201,
  ConditionerStatus.hot30: ConditionerCommand.set_202,
  ConditionerStatus.off: ConditionerCommand.off,
};

Map<ConditionerCommand, String> commandDictionary = {
  ConditionerCommand.off: 'off',
  ConditionerCommand.ping: 'ping',
  ConditionerCommand.set_100: '100',
  ConditionerCommand.set_101: '101',
  ConditionerCommand.set_200: '200',
  ConditionerCommand.set_201: '201',
  ConditionerCommand.set_202: '202',
};
