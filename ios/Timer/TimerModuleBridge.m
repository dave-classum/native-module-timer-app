//
//  TimerModuleBridge.m
//  NativeModuleTimerApp
//
//  Created by 이덕행 on 12/7/23.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

// React Native에서 사용할 TimerModule 클래스를 정의합니다.
@interface RCT_EXTERN_MODULE(TimerModule, RCTEventEmitter)

// 타이머 준비 메소드를 정의합니다. JavaScript에서 호출 가능합니다.
RCT_EXTERN_METHOD(
                  prepareTimer:
                  (RCTPromiseResolveBlock) resolve
                  withReject:
                  (RCTPromiseRejectBlock) reject
                  )

// 타이머 시작 메소드를 정의합니다. JavaScript에서 호출 가능합니다.
RCT_EXTERN_METHOD(
                  startTimer:
                  (RCTPromiseResolveBlock) resolve
                  withReject:
                  (RCTPromiseRejectBlock) reject
                  )

// 타이머 일시 정지 메소드를 정의합니다. JavaScript에서 호출 가능합니다.
RCT_EXTERN_METHOD(
                  pauseTimer:
                  (RCTPromiseResolveBlock) resolve
                  withReject:
                  (RCTPromiseRejectBlock) reject
                  )

// 타이머 종료 메소드를 정의합니다. JavaScript에서 호출 가능합니다.
RCT_EXTERN_METHOD(
                  finalizeTimer:
                  (RCTPromiseResolveBlock) resolve
                  withReject:
                  (RCTPromiseRejectBlock) reject
                  )

// 타이머 리셋 메소드를 정의합니다. JavaScript에서 호출 가능합니다.
RCT_EXTERN_METHOD(
                  resetTimer:
                  (RCTPromiseResolveBlock) resolve
                  withReject:
                  (RCTPromiseRejectBlock) reject
                  )

// 이 모듈이 메인 스레드에서 실행되어야 함을 나타냅니다. 성능 최적화를 위해 필요한 경우 변경할 수 있습니다.
+ (BOOL)requiresMainQueueSetup
{
  return YES;
}
@end
