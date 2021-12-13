{
  Project: EE-7 MyLiteKit
  Platform: Parallax Project USB Board
  Revision: 1.1
  Author: Zofia
  Date: 15th Nov 2021
  Log:
    Date: Desc
}

CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
  _MS_001 = _ConClkFreq / 1_000

OBJ

  Term        : "FullDuplexSerial.spin"
  Sensor      : "SensorControl.spin"
  Motor       : "MotorControl.spin"
  Comm        : "CommControl.spin"

PUB Main

    Motor.Init
    Sensor.Init

    Pause(2000)
    Motor.Forward(2000)
    repeat
      Sensor.ReadUltrasonic(1)

    if(Sensor.ReadUltrasonic(1)) > 200
      Motor.StopAllMotors
      Pause(2000)

    Motor.Reverse(2000)
    repeat
      Sensor.ReadUltrasonic(2)

    if(Sensor.ReadUltrasonic(2)) > 200
      Motor.StopAllMotors
      Pause(2000)

    Motor.Forward(2000)
    repeat
      Sensor.ReadToF(1)

    if (Sensor.ReadToF(1)) < 60
      Motor.StopAllMotors
      Pause(2000)

    Motor.Reverse(2000)
    repeat
      Sensor.ReadToF(2)

    if (Sensor.ReadToF(2)) < 60
        Motor.StopAllMotors
        Pause(2000)

PRI Pause(ms) | t

  t := cnt - 1088
  repeat (ms #> 0)
    waitcnt(t += _MS_001)
  return