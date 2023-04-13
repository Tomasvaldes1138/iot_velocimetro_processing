import processing.serial.*;
Serial myPort;  // Create object from Serial class
int estadoActual1=0;
int estadoActual2=0;
int estadoUltimo=0;
int contador=0;
float radioEnCm=30;   //INGRESAR radio de la rueda en cm
float pi=3.1416;
float perimetroRueda=2*pi*(radioEnCm/100);  //Calcula Perimetro en metros
float distRecorrida=0;
float distKM=0;
int tiempo1=0;
int tiempo2=0;
int tiempo3=0;
float tiempo4=0;
float velocidad=0;

void setup(){
        size(400, 400);
        myPort = new Serial(this, "COM5", 9600);
}

void draw(){
        if ( myPort.available() > 0) {
              estadoActual1 = myPort.read();
              delay(10);
              estadoActual2 = myPort.read();
              if (estadoActual1 == estadoActual2) {
                    if (estadoActual1 != estadoUltimo){
                          if (estadoActual1 == 1) {
                              contador = contador + 1;
                              println("Vueltas " + contador);
                              distancia();
                              VEL();
                          }
                    }
              }
              estadoUltimo= estadoActual1;
                    
              if (contador%2 == 0 ) {
                    fill(0);
              }
              else {
                    fill(255);
              }
              PantallaLCD();
        }
}

void distancia(){
  distRecorrida=perimetroRueda*contador;
  distKM=distRecorrida/1000;
  if(distRecorrida<=999){
          println("Distancia recorrida en m= " + distRecorrida);
  }
  else{
          println("Distancia recorrida en Km= " + distKM);
  }
  }

void VEL(){
        if (contador%2 == 0 ) {
              tiempo1=millis();
        }
        else {
              tiempo2=millis();
        }
        tiempo3=abs(tiempo2-tiempo1); //hay que pasar el tiempo a hrs
        tiempo4=(((tiempo3/1000.0)/60)/60);
        println(tiempo3);
        velocidad=((perimetroRueda/1000)/tiempo4);
        println("velocidad= " + velocidad);        
}


 void PantallaLCD(){
            background(255);
            fill(0);
            textSize(20);
            text("V=", 50, 50);
            text(velocidad, 100, 50);
            text("Km/hr", 150, 50);
            textSize(15);
            if(distRecorrida<=999){
                    text("D=", 50, 100);
                    text(distRecorrida, 100, 100);
                    text("m", 150, 100);
            }
            else{
                    text("D=", 50, 100);
                    text(distKM, 100, 100);
                    text("Km", 150, 100);
            }
            return;
}
