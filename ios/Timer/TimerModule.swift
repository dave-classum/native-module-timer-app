//
//  TimerModule.swift
//  NativeModuleTimerApp
//
//  Created by 이덕행 on 12/7/23.
//


import Foundation
import React

// React Native 모듈로 TimerModule 클래스를 정의합니다.
@objc(TimerModule)
@objcMembers
class TimerModule: RCTEventEmitter {
  
  // 타이머 관리자 인스턴스
  var timer: TimerManager?
  
  // JavaScript에서 구독할 수 있는 이벤트 목록을 반환합니다.
  override func supportedEvents() -> [String]! {
    return ["timer"]
  }
  
  // 메인 스레드에서 모듈 초기화를 요구하지 않음을 나타냅니다.
  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  // 타이머를 준비하는 메소드입니다. 타이머 관리자를 초기화하고 타이머를 준비합니다.
  @objc
  func prepareTimer(_ resolve: @escaping RCTPromiseResolveBlock, withReject reject: @escaping RCTPromiseRejectBlock) {
    timer = TimerManager(self)
    timer?.prepareTimer()
    resolve(true) // 성공적으로 처리됨을 알립니다.
  }
  
  // 타이머 시작 메소드
  @objc
  func startTimer(_ resolve: @escaping RCTPromiseResolveBlock, withReject reject: @escaping RCTPromiseRejectBlock) {
    timer?.startTimer()
    resolve(true) // 성공적으로 처리됨
  }
  
  // 타이머 일시 정지 메소드
  @objc
  func pauseTimer(_ resolve: @escaping RCTPromiseResolveBlock, withReject reject: @escaping RCTPromiseRejectBlock) {
    timer?.pauseTimer()
    resolve(true) // 성공적으로 처리됨
  }
  
  // 타이머 종료 메소드
  @objc
  func finalizeTimer(_ resolve: @escaping RCTPromiseResolveBlock, withReject reject: @escaping RCTPromiseRejectBlock) {
    timer?.finalizeTimer()
    resolve(true) // 성공적으로 처리됨
  }
  
  // 타이머 리셋 메소드
  @objc
  func resetTimer(_ resolve: @escaping RCTPromiseResolveBlock, withReject reject: @escaping RCTPromiseRejectBlock) {
    timer?.resetTimer()
    resolve(true) // 성공적으로 처리됨
  }
}
