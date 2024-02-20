import React, {FC, useEffect, useRef, useState} from 'react';
import {StyleSheet, Text, TouchableOpacity, View} from 'react-native';
import NativeTimer, {TimerEvent} from '../../nativeTimer';

type TimerState = 'idle' | 'started' | 'stopped' | 'finalized';

const TimerScreen: FC = () => {
  const [duration, setDuration] = useState<number>(0);
  const timerState = useRef<TimerState>('idle');

  const changeTimerState = {
    idle: () => {
      NativeTimer.prepareTimer();
      NativeTimer.startTimer();
    },
    started: () => console.log('Timer is already started.'),
    stopped: () => {
      NativeTimer.startTimer();
    },
    finalized: () => {
      NativeTimer.prepareTimer();
      NativeTimer.startTimer();
    },
  };

  const startTimer = () => {
    changeTimerState[timerState.current]?.();
    timerState.current = 'started';
  };

  const pauseTimer = () => {
    if (timerState.current === 'finalized') return;
    NativeTimer.pauseTimer();
    timerState.current = 'stopped';
  };

  const finalizeTimer = () => {
    NativeTimer.finalizeTimer();
    timerState.current = 'finalized';
  };

  const resetTimer = () => {
    NativeTimer.resetTimer();
    timerState.current = 'finalized';
  };

  useEffect(() => {
    const subscribeTimer = (time: TimerEvent) => setDuration(time.duration);
    const timerEvent = NativeTimer.eventEmitter.addListener(
      'timer',
      subscribeTimer,
    );

    return () => {
      timerEvent.remove();
      finalizeTimer();
    };
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.durationText}>{duration}</Text>
      <View style={styles.buttonBox}>
        <TouchableOpacity onPress={startTimer} style={styles.button}>
          <Text style={styles.buttonText}>시작</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={pauseTimer} style={styles.button}>
          <Text style={styles.buttonText}>일시정지</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={finalizeTimer} style={styles.button}>
          <Text style={styles.buttonText}>종료</Text>
        </TouchableOpacity>
      </View>
      <TouchableOpacity onPress={resetTimer} style={styles.button}>
        <Text style={styles.buttonText}>리셋</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  durationText: {
    fontSize: 150,
    color: 'gray',
  },
  buttonBox: {
    flexDirection: 'row',
    marginTop: 50,
    marginBottom: 10,
  },
  button: {
    backgroundColor: '#000',
    paddingHorizontal: 30,
    paddingVertical: 10,
    borderRadius: 10,
    marginHorizontal: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontWeight: '700',
    fontSize: 20,
  },
});

export default TimerScreen;
