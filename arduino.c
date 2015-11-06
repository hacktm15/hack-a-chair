#define MAX_READS  10
#define SENSORS  5

// #include "SoftwareSerial.h";
// int bluetoothTx = 2;
// int bluetoothRx = 3;

// SoftwareSerial bluetooth(bluetoothTx, bluetoothRx);

// declare the pins
int topLeft = A1;
int topRight = A2;
int bottomLeft = A3;
int bottomMid = A4;
int bottomRight = A5;
int index = 0;
long values[SENSORS][MAX_READS];

void setup() {
  // Serial communication
  Serial.begin(9600);

  // bluetooth.begin(115200);
  // bluetooth.print("$$$");
  // delay(100);
  // bluetooth.println("U,9600,N");
  // bluetooth.begin(9600);

  // Set the pin type
  pinMode(topLeft, INPUT);
  pinMode(topRight, INPUT);
  pinMode(bottomLeft, INPUT);
  pinMode(bottomMid, INPUT);
  pinMode(bottomRight, INPUT);
}

void loop() {

  if (index < MAX_READS) {
    // read values
    values[0][index] = analogRead(topLeft);
    values[1][index] = analogRead(topRight);
    values[2][index] = analogRead(bottomLeft);
    values[3][index] = analogRead(bottomMid);
    values[4][index] = analogRead(bottomRight);
    index++;
  } else {
    // caculate the mean for every device
    index = 0;
    long means[SENSORS];
    means[0] = mean(values[0]);
    means[1] = mean(values[1]);
    means[2] = mean(values[2]);
    means[3] = mean(values[3]);
    means[4] = mean(values[4]);

    // send data via bluetooth as string, parse the values later
    Serial.println("BEGIN");
    Serial.println(means[0]);
    Serial.println(means[1]);
    Serial.println(means[2]);
    Serial.println(means[3]);
    Serial.println(means[4]);
    Serial.println("END");
  }

  // delay 10 nano seconds
  delay(25);
}

long mean(long *arr) {
  long sum = 0;
  for (int i = 0; i < MAX_READS; i++) {
    sum  += arr[i];
  }
  return sum / MAX_READS; 
}
