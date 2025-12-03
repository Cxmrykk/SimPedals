#include "HX711.h"
#include "HID-Project.h"
#include "EEPROM.h"

//User Configurable Values

const int deadBand = 2; //Adjust higher if you find inputs are activating without any user input.
int clutchPin = A3; //Analog pin that clutch is connected to
int throttlePin = A2; //Analog pin that throttle is connected to
uint8_t dataPin = 2; //Load Cell Amplifier Data Pin
uint8_t clockPin = 3; //Load Cell Amplifier Clock Pin

//Do not modify any values below this line.

int XYRangeMax = 32767;
int XYRangeMin = -32768;
int ZRangeMax = 127;
int ZRangeMin = -128;

bool enableAutoCalibration = false;
unsigned long calibrationTimer;

//Calibration values
int clutchMin = 10000;
int clutchMax = 0;

int throttleMin = 10000;
int throttleMax = 0;

int brakeMin = 10000;
int brakeMax = 0;

//Raw value storage
int clutchValue;
int throttleValue;
int brakeValue;

//Load Cell Setup
float loadCellScale = 420.0983;
HX711 scale;

void setup() {
  Serial.begin(115200);
  delay(500);

  readCalibrationData(1);

  scale.begin(dataPin, clockPin);
  scale.set_scale(loadCellScale);
  scale.tare();

  Serial.println("Do you wish to calibrate? y/n");
  Gamepad.begin();

}

void loop() {
  if(Serial){
    if (Serial.available() > 0) {
      char c = Serial.read();
      if (c == '\n' || c == '\r') return;
      if (c == 'y' || c == 'Y') {
        Serial.println("Begin Auto Calibration...");
        Serial.println("Move all pedals to their full extents multiple times. Calibration will complete Automatically in 1 minute.");
        enableAutoCalibration = true;
        calibrationTimer = millis();

        //Reset calibration values
        clutchMin = 10000;
        clutchMax = 0;

        throttleMin = 10000;
        throttleMax = 0;

        brakeMin = 10000;
        brakeMax = 0;
      }
    }
  }

  readInput();

  if(enableAutoCalibration){
    autoCalibration();
    if(calibrationTimer + 60000 < millis()){ //If 1 minute has passed without any calibration adjustment, disable calibration and store values. 
      enableAutoCalibration = false;
      writeCalibrationData(1);
      Serial.println("Calibration Complete!");
    }
  } else {
    Gamepad.xAxis(outputScale(clutchValue, clutchMin, clutchMax, XYRangeMin, XYRangeMax));
    Gamepad.yAxis(outputScale(throttleValue, throttleMin, throttleMax, XYRangeMin, XYRangeMax));
    Gamepad.zAxis(outputScale(brakeValue, brakeMin, brakeMax, ZRangeMin, ZRangeMax));

    Gamepad.write();
  }
}

void autoCalibration(){
  if(clutchValue > clutchMax){
    clutchMax = clutchValue;
  }
  if(clutchValue < clutchMin && clutchValue > 0){
    clutchMin = clutchValue;
  }

  if(throttleValue > throttleMax){
    throttleMax = throttleValue;
  }
  if(throttleValue < throttleMin && throttleValue > 0){
    throttleMin = throttleValue;
  }

  if(brakeValue > brakeMax){
    brakeMax = brakeValue;
  }
  if(brakeValue < brakeMin && brakeValue > 0){
    brakeMin = brakeValue;
  }
}

void readInput(){
  clutchValue = analogRead(A3);
  throttleValue = analogRead(A2);
  brakeValue = scale.get_units(5);
}

int outputScale(int value, int min, int max, int rangeMin, int rangeMax){ 
  if(value > max){
    value = max;
  }
  if(value < min && value > 0){
    value = min;
  }
  if(value < min + deadBand){
    return rangeMin;
  }
  if(value > max - deadBand){
    return rangeMax;
  }

  return map(value, min, max, rangeMin, rangeMax);

}

void writeIntIntoEEPROM(int address, int number){ //Splits int "number" into BYTES and writes to EEPROM at given address
  byte byte1 = number >> 8;
  byte byte2 = number & 0xFF;
  EEPROM.write(address, byte1);
  EEPROM.write(address + 1, byte2);
}

int readIntFromEEPROM(int address){ //Returns int value from EEPROM adress +1
  byte byte1 = EEPROM.read(address);
  byte byte2 = EEPROM.read(address + 1);
  return (byte1 << 8) + byte2;
}

void readCalibrationData(int startAdr){ //Read calibration data from EEPROM
  clutchMin = readIntFromEEPROM(1 + startAdr);
  clutchMax = readIntFromEEPROM(3 + startAdr);
  throttleMin = readIntFromEEPROM(5 + startAdr);
  throttleMax = readIntFromEEPROM(7 + startAdr);
  brakeMin = readIntFromEEPROM(9 + startAdr);
  brakeMax = readIntFromEEPROM(11 + startAdr);
}

void writeCalibrationData(int startAdr){ //Store calibration data in EEPROM
  writeIntIntoEEPROM(1 + startAdr, clutchMin);
  writeIntIntoEEPROM(3 + startAdr, clutchMax);
  writeIntIntoEEPROM(5 + startAdr, throttleMin);
  writeIntIntoEEPROM(7 + startAdr, throttleMax);
  writeIntIntoEEPROM(9 + startAdr, brakeMin);
  writeIntIntoEEPROM(11 + startAdr, brakeMax);
}
