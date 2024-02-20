package com.nativemoduletimerapp.timer

import com.facebook.react.bridge.*
import java.lang.IllegalStateException

class TimerModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "TimerModule"
    }

    private var timer: TimerManager? = null

    // 타이머 준비 메소드
    @ReactMethod
    fun prepareTimer(promise: Promise) {
        timer = TimerManager(reactApplicationContext).also {
            it.prepareTimer()
        }
        promise.resolve(true) // 성공적으로 타이머 준비 완료
    }

    // 타이머 시작 메소드
    @ReactMethod
    fun startTimer(promise: Promise) {
        timer?.let {
            it.startTimer()
            promise.resolve(true) // 성공적으로 타이머 시작
        } ?: promise.reject(IllegalStateException("타이머가 준비되지 않았습니다."))
    }

    // 타이머 일시 정지 메소드
    @ReactMethod
    fun pauseTimer(promise: Promise) {
        timer?.let {
            it.pauseTimer()
            promise.resolve(true) // 성공적으로 타이머 일시 정지
        } ?: promise.reject(IllegalStateException("타이머가 준비되지 않았습니다."))
    }

    // 타이머 종료 메소드
    @ReactMethod
    fun finalizeTimer(promise: Promise) {
        timer?.let {
            it.finalizeTimer()
            promise.resolve(true) // 성공적으로 타이머 종료
        } ?: promise.reject(IllegalStateException("타이머가 준비되지 않았습니다."))
    }

    // 타이머 리셋 메소드
    @ReactMethod
    fun resetTimer(promise: Promise) {
        timer?.let {
            it.resetTimer()
            promise.resolve(true) // 성공적으로 타이머 리셋
        } ?: promise.reject(IllegalStateException("타이머가 준비되지 않았습니다."))
    }
}