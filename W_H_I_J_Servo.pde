#include <Servo.h>

/**
 Author: Frank Hernandez
 Date: November, 2010
 
 Project Name: Werewolf Head In Jar (W.H.I.J.)
 Project Type: Halloween
 
 Script for controlling the werewolf head and the 
 tank's LED. The tank's LED remain on until the 
 werewolf begins to open it mouth at which time
 they being to flicker and eventually turn off
 when the werewolf is finished closing its mouth.
 
 I wanted to create the effect of tank failure
 to accompany the opening/closing of the mouth.
 Make it seem like the tank is malfunctioning 
 and thus the head is trying to break through. 
**/
Servo myServo;

int servoPin = 9;
int val = 0;

// Pin number for the wolf's eyes.
int eyesPin = 7;
// Pin for the tank's LED
int tankLEDPin = 6;
int servoMaxRotation = 25;//35;//45;//45;//90;

int servoSpeed = 1;
int servoDelay = 15;
boolean invert = false;
boolean close = false;

int pos = 0;
void setup()
{
 myServo.attach(servoPin);
 // Set the eyes pin for writing.
 pinMode(eyesPin, OUTPUT);     
 pinMode(tankLEDPin, OUTPUT);
}

void loop()
{

  // Open Mouth
  OpenMouth();
  delay(2000);
  // Close Mouth
  CloseMouth();
  // Turn Tank LEDs back on.
  FlickerLEDS(3);  
  delay(7000);
}
/**
  Function to handle the moving of the servo
  into the open position of the mouth. 
  At each step it also makes a call to 
  FlickerLEDs to cuase the LEDs to flicker.
**/
void OpenMouth()
{
  digitalWrite(eyesPin, HIGH);
  for(pos = 0; pos < servoMaxRotation; pos += servoSpeed)   
  {                                   
    myServo.write(pos);              
    FlickerLEDS(pos);
    delay(servoDelay);                
  } 
}
/**
  Function to handle the moving of the servo
  into the close position of the mouth. 
  At each step it also makes a call to 
  FlickerLEDs to cuase the LEDs to flicker.
**/
void CloseMouth()
{
  for(pos = servoMaxRotation; pos>=1; pos-=servoSpeed)      
  {                                
    myServo.write(pos);     
    FlickerLEDS(pos);
    delay(servoDelay);                        
  } 
  digitalWrite(eyesPin, LOW);
  
}
void FlickerLEDS(int number)
{
   if(number % 4 <= 2)
      digitalWrite(tankLEDPin, LOW);
   else
      digitalWrite(tankLEDPin, HIGH);   
}
