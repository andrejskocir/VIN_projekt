#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// Pin definitions for the ultrasonic sensor
#define TRIG_PIN PA0
#define ECHO_PIN PA1

LiquidCrystal_I2C lcd(0x27, 16, 2);  // set the LCD address to 0x27 for a 16 chars and 2 line display

// Time intervals
unsigned long serialInterval = 3000;  // Interval for serial output (in milliseconds)
unsigned long lcdInterval = 1000;     // Interval for LCD update (in milliseconds)

unsigned long previousLCDMillis = 0;

void setup() {
  // Initialize the LCD
  lcd.init();
  lcd.begin(16, 2);  // initialize the lcd
  lcd.backlight();

  // Print initial message to the LCD
  lcd.print("OKEJ");

  // Initialize serial communication for debugging
  Serial.begin(9600);

  // Set up the ultrasonic sensor pins
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  // Confirmation message to serial monitor
  Serial.println("Setup complete. Waiting for input...");
}

void loop() {
  // Get the current time
  unsigned long currentMillis = millis();

  // Measure the distance with the ultrasonic sensor
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  long duration = pulseIn(ECHO_PIN, HIGH);
  long distance = duration * 0.034 / 2;


  // Update the LCD display every 1000 ms
  if (currentMillis - previousLCDMillis >= lcdInterval) {
    previousLCDMillis = currentMillis;  // Update the last LCD update time

    Serial.print(distance);

    // Print the distance to the LCD
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Distance: ");
    lcd.setCursor(0, 1);
    lcd.print(distance);
    lcd.print(" cm");
  }
}
