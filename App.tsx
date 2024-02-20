import React from 'react';
import {SafeAreaView} from 'react-native';

import TimerScreen from './src/screens/TimerScreen';

function App(): JSX.Element {
  return (
    <SafeAreaView style={{flex: 1}}>
      <TimerScreen />
    </SafeAreaView>
  );
}

export default App;
