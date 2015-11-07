#define MAX_READS  10
#define SENSORS  5

#include "SoftwareSerial.h";
int bluetoothTx = 3;
int bluetoothRx = 2;

SoftwareSerial bluetooth(bluetoothTx, bluetoothRx);

// tt tm tb bl br

// declare the pins
int tt = A0;
int tm = A1;
int tb = A2;
int bl = A3;
int br = A4;
int ledTx = 10;
long values[SENSORS];

void setup() {
  bluetooth.begin(57600);
  // Set the pin type
  pinMode(tt, INPUT);
  pinMode(tm, INPUT);
  pinMode(tb, INPUT);
  pinMode(bl, INPUT);
  pinMode(br, INPUT);
  pinMode(ledTx, OUTPUT);
}

void loop() {
  values[0] = analogRead(tt); 
  values[1] = analogRead(tm);
  values[2] = analogRead(tb);
  values[3] = analogRead(bl);
  values[4] = analogRead(br);
  bluetooth.print(values[0]);
  bluetooth.print(',');
  bluetooth.print(values[1]);
  bluetooth.print(',');
  bluetooth.print(values[2]);
  bluetooth.print(',');
  bluetooth.print(values[3]);
  bluetooth.print(',');
  bluetooth.print(values[4]);
  bluetooth.print('\n');
  
  digitalWrite(ledTx, HIGH);
  delay(200);
  digitalWrite(ledTx, LOW);
  delay(100);
}
