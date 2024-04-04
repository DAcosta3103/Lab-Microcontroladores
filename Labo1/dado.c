#include <pic14/pic12f683.h>

//Primero, definamos los pines

#define BOTON   GP3 // Conectamos el botón al pin GP3
#define Salida0 GP0 // Pin GP0
#define Salida1 GP1  // Pin GP1
#define Salida2 GP2  // Pin GP2
#define Salida4 GP4  // Pin GP4
#define Salida5 GP5  // Pin GP5

unsigned int seed = 0;      // Declaramos la variable semilla para la generación de números pseudoaleatorios



// Función para generar un número aleatorio entre 1 y 6
int generarNumeroAleatorio() {
    seed = seed + 1;                    // Incrementamos la semilla
    return ((seed * 32719 + 3) % 6) + 1; // Generamos un número entre 1 y 6
}


void delay(unsigned int tiempo)
{
    unsigned int i, j;
    for(i = 0; i < tiempo; i++)
    {
        for(j = 0; j < 1000; j++)
        {
        }
    }
}


void main(){
    // Empezamos por inicializar el MCU
    ANSEL = 0x00;
    TRISIO = 0b00001000;  // Ponemos todos los pines como salida excepto por GP3, el cual corresponde al botón
    GPIO = 0x00;          // Todos los pines inician en bajo
    int numero = 0;        // Aquí almacenaremos el número obtenido
    unsigned int tiempo = 2000;        // Seteamos el tiempo de delay a 2000 ms (2 segundos)

// Loop forever
while (1){
    if (BOTON == 1){      // Nos aseguramos de solo operar cuando el boton se presione
        numero = generarNumeroAleatorio();
        if (numero == 1){
            Salida0 = 1;
        } else if (numero == 2){
            Salida1 = 1;
        } else if (numero == 3){
            Salida0 = 1;
            Salida1 = 1;
        } else if (numero == 4){
            Salida0 = 1;
            Salida1 = 1;
            Salida2 = 1;
        } else if (numero == 5){
            Salida0 = 1;
            Salida1 = 1;
            Salida2 = 1;
            Salida4 = 1;
        } else if (numero == 6){
            Salida0 = 1;
            Salida1 = 1;
            Salida2 = 1;
            Salida4 = 1;
            Salida5 = 1;
            }
        }
    delay(tiempo);
    Salida0 = 0;
    Salida1 = 0;
    Salida2 = 0;
    Salida4 = 0;
    Salida5 = 0;

    }
}

