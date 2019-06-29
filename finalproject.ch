/* Photoresistor data, baselineLightVal  speed code, (instead of potentiator use light resistor)  */


#include <arduino.h>
#include <linkbot.h>
//header
CLinkbotI robo;
//Identifying a variable

double radius = 1.75;
double speed;
double angularSpeed= 0;
int sensorPin = A0, //Photo resistor in the arduino, analog//
    tempPin = A1,  //temperature sensor in the arduino, analog//
    sensorVal,  //Photo resistor value//
    tempSensorVal,  // Temperature sensor value//
    pinNumber,
    lightVal;  //Light value for the photo resistor//

double baseline = 200.0;  // Set up the baseline for the photo resistor and the temperature sensor//
double baselineTemp = 27.0,
       voltage,
       temperature;

pinMode(A0,INPUT); // A0 and A1 are the analog pins connected to the temp. sensor and the photo resistor//
pinMode(A1,INPUT);
pinMode(5,OUTPUT); //red LED
pinMode(4,OUTPUT); //yellow LED
pinMode(3,OUTPUT); //green LED
//pins for photoresistor and LED's

robo.setSpeed (0, radius);
robo.driveForeverNB();  // When the robot is turning, the robot will still drive and continue forever//
robo.setJointSpeeds(angularSpeed, NaN, angularSpeed);
while(1){
    printf("start of while loop\n");
    
    sensorVal = analogRead (sensorPin);//calculate sensor value from the photoresistor
    lightVal = (sensorVal/4.0);
    printf ("Photosensor Value: %d", sensorVal);
    printf (", Light value: %d\n", lightVal);
    tempSensorVal = analogRead (tempPin);
    voltage = (tempSensorVal/1023.0)*5.0;
    temperature = (voltage - 0.5)*100;
    printf ("Tempsensor value: %d", tempSensorVal);
    printf (", Voltage: %.2lf", voltage);
    printf (", degrees C: %.2lf\n", temperature);
    
    printf("checking lightVal\n");
    if (lightVal < baseline){
        digitalWrite(5, HIGH); // One of the lights turn on when the light value is below the baseline//
        digitalWrite(4, LOW);
        digitalWrite(3, LOW);
        robo.setSpeed(0,radius);
        robo.setLEDColor("red");
        
    }
    else if(lightVal >= baseline && lightVal < (baseline+25)){
        digitalWrite(5,LOW);  //When the light is right at the baseline or a little above the baseline//
        digitalWrite(4,HIGH);
        digitalWrite(3,LOW);
        robo.setSpeed(3,radius);
        robo.setLEDColor("yellow");
    }
    else if(lightVal >= (baseline+25)){
        digitalWrite(5,LOW);  //When the light value is above the baseline//
        digitalWrite(4,LOW);
        digitalWrite(3,HIGH);
        robo.setSpeed(6,radius);
        robo.setLEDColor("green");
        if (temperature >= baselineTemp ){
   
       robo.turnRightNB(300, radius, 3.69); //The robot will turn right when the light value is above the baseline//
        
    }
    }
    
  robo.driveForeverNB(); //robot will still drive forever even after turning//

    delay(500);
    
    }
