package com.nativemoduletimerapp.timer

import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager

class TimerPackage : ReactPackage {

    // 뷰 매니저 생성. 현재 Timer 모듈에는 뷰 매니저가 필요 없으므로 빈 목록 반환
    override fun createViewManagers(
        reactContext: ReactApplicationContext
    ): MutableList<ViewManager<*, *>> = mutableListOf()

    // 네이티브 모듈 생성. TimerModule 인스턴스를 포함하는 목록 반환
    override fun createNativeModules(
        reactContext: ReactApplicationContext
    ): MutableList<NativeModule> = mutableListOf(TimerModule(reactContext))
}