#include <arduino.h>
#include <linkbot.h>
//header
CLinkbotI robo;
//Identifying a variable

double radius = 1.75;
double speed;
int sensorPin = A0,
tempPin = A1,
sensorVal,
tempVal
pinNumber,
lightVal;

double baseline = 200.0;
double baselineTemp = 30.0,
       voltage,
       temperature;

pinMode(A0,INPUT);
pinMode(A1,INPUT);
pinMode(5,OUTPUT); //red
pinMode(4,OUTPUT); //yellow
pinMode(3,OUTPUT); //green
//pins for photoresistor and LED's

robo.setSpeed (0, radius);
robo.driveForeverNB();

while(1){
    sensorVal = analogRead (sensorPin);//calculate sensor value from the photoresistor
    lightVal = (sensorVal/4.0);
    printf ("Sensor Value: %d", sensorVal);
    printf (", Light value: %d\n", lightVal);
    if (lightVal < baseline){
        digitalWrite(5, HIGH);
        digitalWrite(4, LOW);
        digitalWrite(3, LOW);
        robo.setSpeed(0,radius);
        robo.setLEDColor("red");
    }
    else if(lightVal >= baseline && lightVal < (baseline+25)){
        digitalWrite(5,LOW);
        digitalWrite(4,HIGH);
        digitalWrite(3,LOW);
        robo.setSpeed(1,radius);
        robo.setLEDColor("yellow");
    }
    else if(lightVal >= (baseline+25)){
        digitalWrite(5,LOW);
        digitalWrite(4,LOW);
        digitalWrite(3,HIGH);
        robo.setSpeed(6,radius);
        robo.setLEDColor("green");
    }
    delay(500);
}
