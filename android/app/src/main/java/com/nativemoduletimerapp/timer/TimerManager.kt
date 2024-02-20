package com.nativemoduletimerapp.timer

import android.util.Log
import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule.RCTDeviceEventEmitter

// 타이머 이벤트 리스너 인터페이스 정의
interface TimerEventListener {
    fun onTimer(duration: Long)
}

class TimerManager(
    private val reactContext: ReactApplicationContext
) : TimerEventListener {
    companion object {
        const val LOG_TAG = "Timer"
    }

    private var duration: Long = 0
    private var timestamp: Long = 0
    private var isPaused: Boolean = false
    private var isPrepare: Boolean = true
    private var isStarted: Boolean = false
    private var timerThread: Thread? = null

    // 이벤트 발송 함수
    private fun emit(eventName: String, params: WritableMap?) {
        reactContext.getJSModule(RCTDeviceEventEmitter::class.java).emit(eventName, params)
    }

    // TimerEventListener 구현
    override fun onTimer(duration: Long) {
        val eventMap = WritableNativeMap().apply {
            putDouble("duration", duration.toDouble())
        }
        emit("timer", eventMap)
    }

    // 타이머 준비
    fun prepareTimer() {
        isPrepare = true
        timerThread = Thread {
            while (isPrepare) {
                val nowTime = System.currentTimeMillis() / 1000
                if (isStarted && !isPaused) {
                    duration += nowTime - timestamp
                    onTimer(duration)
                }
                timestamp = nowTime
                Thread.sleep(1000)
            }
        }.also { it.start() }
    }

    // 타이머 시작
    fun startTimer() {
        if (!isStarted) {
            timestamp = System.currentTimeMillis() / 1000
            isStarted = true
        }
        isPaused = false
        Log.i(LOG_TAG, "startTimer!")
    }

    // 타이머 일시 정지
    fun pauseTimer() {
        isPaused = true
        Log.i(LOG_TAG, "pauseTimer!")
    }

    // 타이머 종료
    fun finalizeTimer() {
        isPrepare = false
        isStarted = false
        isPaused = false
        timestamp = 0
        duration = 0
        Log.i(LOG_TAG, "finalizeTimer!")
    }

    // 타이머 리셋
    fun resetTimer() {
        finalizeTimer()
        onTimer(duration) // 현재 duration은 0으로 초기화되었습니다.
        Log.i(LOG_TAG, "resetTimer!")
    }
}