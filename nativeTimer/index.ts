import {
  NativeEventEmitter,
  NativeModules,
  EmitterSubscription,
  EventEmitter,
} from 'react-native';

export interface TimerEvent {
  duration: number;
}

interface NativeTimerExtension {
  eventEmitter: NativeTimerEventEmitter;
}

interface NativeTimerEventEmitter extends EventEmitter {
  addListener(
    eventType: 'timer',
    listener: (data: TimerEvent) => void,
  ): EmitterSubscription;
}

interface NativeTimerInterface {
  prepareTimer(): Promise<boolean>;
  startTimer(): Promise<boolean>;
  pauseTimer(): Promise<boolean>;
  finalizeTimer(): Promise<boolean>;
  resetTimer(): Promise<boolean>;
}

const TimerExtension: NativeTimerExtension = {
  eventEmitter: new NativeEventEmitter(NativeModules.TimerModule),
};

type NativeTimer = NativeTimerInterface & NativeTimerExtension;

const NativeTimer: NativeTimer = {
  ...NativeModules.TimerModule,
  ...TimerExtension,
};
export default NativeTimer;
