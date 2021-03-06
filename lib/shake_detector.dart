import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShakeDetector {
  final VoidCallback onPhoneShake;

  final double shakeThresholdGravity;

  final int minTimeBetweenShakes;

  final int shakeCountResetTime;

  final int minShakeCount;

  int shakeCount = 0;

  int lastShakeTimestamp = DateTime.now().millisecondsSinceEpoch;

  StreamSubscription streamSubscription;

  ShakeDetector({
    this.onPhoneShake,
    this.shakeThresholdGravity = 1.25,
    this.minTimeBetweenShakes = 160,
    this.shakeCountResetTime = 1500,
    this.minShakeCount = 2,
  });

  /// Starts listening to accerelometer events
  void startListening() {
    streamSubscription = accelerometerEvents.listen((event) {
      var gX = event.x / 9.81;
      var gY = event.y / 9.81;
      var gZ = event.z / 9.81;

      // gForce will be close to 1 when there is no movement.
      var gForce = sqrt(gX * gX + gY * gY + gZ * gZ);
      if (gForce > shakeThresholdGravity) {
        var now = DateTime.now().millisecondsSinceEpoch;
        // ignore shake events too close to each other
        if (lastShakeTimestamp + minTimeBetweenShakes > now) {
          return;
        }

        // reset the shake count after 1.5 seconds of no shakes
        if (lastShakeTimestamp + shakeCountResetTime < now) {
          shakeCount = 0;
          debugPrint("摇一摇次数已经重置");
        }


        lastShakeTimestamp = now;
        if (++shakeCount >= minShakeCount) {
          shakeCount = 0;
          onPhoneShake();
          debugPrint("摇一摇打开");
        }
      }
    });
  }

  /// Stops listening to accelerometer events
  void stopListening() {
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
  }

  static ShakeDetector autoStart({Function() onPhoneShake}) {
    return ShakeDetector(onPhoneShake: onPhoneShake, minShakeCount: 5)
      ..startListening();
  }

  ///调试模式只需要5次，release模式50次
  static ShakeDetector intelligent({Function() onPhoneShake}) {
    return ShakeDetector(
        onPhoneShake: onPhoneShake,
        minShakeCount: kReleaseMode?50:5,
        shakeCountResetTime: 400,
        minTimeBetweenShakes: 100)
      ..startListening();
  }
}
