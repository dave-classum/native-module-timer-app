//
//  TimerManager.swift
//  NativeModuleTimerApp
//
//  Created by 이덕행 on 12/7/23.
//

import Foundation
import React

// 타이머 이벤트 리스너 프로토콜 정의
protocol TimerEventListener {
  func onTimer(_ duration: Double)
}

class TimerManager {
  // 타이머 상태 변수들
  private(set) public var duration: Double = 0.0
  private(set) public var isPrepare = true
  private(set) public var isStarted = false
  private(set) public var isPaused = false
  private var timestamp: Double = NSDate().timeIntervalSince1970
  
  // React Native 이벤트 에미터
  private var eventEmitter: RCTEventEmitter
  
  // 초기화 메소드
  init(_ eventEmitter: RCTEventEmitter) {
    self.eventEmitter = eventEmitter
  }
  
  // 타이머 이벤트 발생 시 호출되는 메소드
  func onTimer(_ duration: Double) {
    let event: NSDictionary = ["duration": duration]
    eventEmitter.sendEvent(withName: "timer", body: event)
  }
  
  // 타이머 준비 메소드
  func prepareTimer() {
    DispatchQueue.global(qos: .userInitiated).async {
      while (self.isPrepare) {
        let now = NSDate().timeIntervalSince1970
        if self.isStarted && !self.isPaused {
          self.duration += Double(Int(now - self.timestamp))
          self.onTimer(self.duration)
        }
        self.timestamp = now
        sleep(1)
      }
    }
  }
  
  // 타이머 시작 메소드
  func startTimer() {
    if (!isStarted){
      timestamp = NSDate().timeIntervalSince1970
      isStarted = true
    }
    isPaused = false
  }
  
  // 타이머 일시 정지 메소드
  func pauseTimer() {
    isPaused = true
  }
  
  // 타이머 종료 메소드
  func finalizeTimer() {
    duration = 0.0
    isPrepare = false
    isPaused = false
    isStarted = false
  }
  
  // 타이머 리셋 메소드
  func resetTimer() {
    finalizeTimer()
    onTimer(0.0)
  }
}
