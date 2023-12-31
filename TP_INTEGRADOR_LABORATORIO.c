#include <stdio.h>
#include <stdlib.h>
#include <string.h> // comparar caracteres

// Emanuel Camacho
// Felipe Gil
// Mateo Fux
// Gaston Vaccarone
// Sergio Duarte

struct BANCO // estructura principal
{
    int numero_cuenta;
    char contrasena[20];
    char nombre[50];
    int saldo;
    char estado[10];

    int intentos;          // si llega a 3 se bloquea la cuenta
    int operaciones;       // operaciones restantes, limite de 10
    int arr_opera[500][2]; // guardamos el numero de operacion y el valor
    int mov;               // trabaja en conjunto con el de arriba
};

int i, j, k, pos; // variables para for y pos para saber que cliente esta en uso

void CARGA(struct BANCO *clientes);          // cargamos todos lo clientes
void DEPOSITO(struct BANCO *depo);           // funcion para deposito
void EXTRAER(struct BANCO *extra);           // funcion para extraccion
void CONSULTA_SALDO(struct BANCO *consulta); // funcion para consulta de saldo
void OPCION_5(struct BANCO *mirar);          // funcion para la opcion 5
void TRANSFERENCIA(struct BANCO *mover);     // funcion para transferencia

int main()
{
    int opcion, cliente_pedido, menu_valido = 0; // cliente_pedido para el usuario
    int final;                                   // por si quiere ingresar otro cliente
    char clave[20];                              // clave de usuario

    struct BANCO clientes[10];

    CARGA(clientes); // solo carga todos los clientes
    int valido = 0;

    do // repite el ingreso si se carga un cliente bien y el cliente sale de su cuenta o se le terminan las operaciones
    {
        final = 0;
        do // valida el usuario y clave
        {
            printf("\nINGRESE EL NUMERO DE CLIENTE: ");
            scanf("%i", &cliente_pedido);

            printf("INGRESE LA CLAVE: ");
            scanf("%s", &clave);

            for (i = 0; i < 10; i++)
            {
                if (clientes[i].numero_cuenta == cliente_pedido)
                {
                    pos = i;
                    if (strcmp(clientes[i].estado, "ACTIVO") == 0)
                    {
                        if (strcmp(clientes[i].contrasena, clave) == 0)
                        {
                            pos = i;
                            menu_valido = 1; // para que muestre el menu cuando la contraseñas y usuarios sean correctos
                            valido = 1;      // sirve para que no busque mas contraseñas y usuarios
                            i = 9;
                        }
                        else
                        {
                            if (strcmp(clientes[i].contrasena, clave) != 0)
                            {
                                printf("\nNumero de cuenta o clave incorrecta.\n"); // por alguna razon no puedo poner la palabra "contraseña", no me escribe la ñ
                                i = 9;
                            }
                            clientes[i].intentos += 1;
                        }
                    }
                    else
                    {
                        printf("\nESTADO DE CUENTA BLOQUEADO\nCOMUNIQUESE CON LA ENTIDAD BANCARIA\n");
                        i = 9; // salte el else if de abajo, nose porque sino se ejecutan los 2 a la vez "a veces"
                    }
                }
                else if ((i == 9) && (clientes[i].numero_cuenta != cliente_pedido))
                {
                    printf("\nNumero de cuenta o clave incorrecta.\n");
                }

                if (clientes[i].intentos >= 3)
                {
                    i = 9;
                    printf("\nNo se permiten mas intentos.\n");
                    printf("\n");
                    valido = 1;
                    strcpy(clientes[i].estado, "BLOQUEADO");
                }
            }

        } while (valido == 0);

        // MENU

        if (menu_valido == 1) // para que muestre el menu cuando el cliente inicie sesion
        {
            do // repite el menu despues de cada operacion
            {

                printf("\nSeleccione una opcion:\n");
                printf("1. Realizar un Deposito\n");
                printf("2. Realizar una Extraccion\n");
                printf("3. Consultar el Saldo de la Cuenta\n");
                printf("4. Realizar una Transferencia entre Cuentas\n");                  // no restan operaciones
                printf("5. Mostrar cantidad de Operaciones Realizadas y Saldo Actual\n"); // no restan operaciones
                printf("6. Salir de la Sesion\n");
                printf("Opcion: ");
                scanf("%d", &opcion);
                while ((opcion < 1) || (opcion > 6))
                {
                    printf("\nOPCION INCORRECTA\nVUELVA A INGRESARLA: ");
                    scanf("%i", &opcion);
                }

                switch (opcion)
                {
                case 1:
                    if (clientes[pos].operaciones != 0)
                    {
                        DEPOSITO(clientes);
                        clientes[pos].operaciones--;
                    }
                    else
                    {
                        printf("\nHa alcanzado el limite de operaciones. Gracias.\n");
                        opcion = 6;
                        final = 1;
                    }
                    break;

                case 2:

                    if (clientes[pos].operaciones != 0)
                    {
                        if (clientes[pos].saldo == 0)
                        {
                            printf("\nSALDO INSUFICIENTE\n");
                        }
                        else
                        {
                            EXTRAER(clientes);
                            clientes[pos].operaciones--;
                        }
                    }
                    else
                    {
                        printf("\nHa alcanzado el limite de operaciones. Gracias.\n");
                        opcion = 6;
                        final = 1;
                    }
                    break;

                case 3:
                    if (clientes[pos].operaciones != 0)
                    {
                        CONSULTA_SALDO(clientes);
                        clientes[pos].operaciones--;
                        break;
                    }
                    else
                    {
                        printf("\nHa alcanzado el limite de operaciones. Gracias.\n");
                        opcion = 6;
                        final = 1;
                    }
                    break;

                case 4:
                    TRANSFERENCIA(clientes);
                    break;

                case 5:
                    OPCION_5(clientes);
                    break;
                }

            } while (opcion != 6);
        }

        if (final != 1)
        {
            printf("\nQUIERE INGRESAR OTRA CUENTA?");
            printf("\n1. SI");
            printf("\n0. NO");
            printf("\nOPCION: ");
            scanf("%i", &final);
            while (final < 0 || final > 1)
            {
                printf("\nVALOR INCORRECTO");
                printf("\n1. SI");
                printf("\n0. NO");
                printf("\nOPCION: ");
                scanf("%i", &final);
            }
        }

        for (i = 0; i < 10; i++) // REINICIA BOOLEANOS PARA USAR Y LAS OPERACIONES DE TODAS LAS CUENTAS
        {
            clientes[i].operaciones = 10;
            clientes[i].intentos = 0;
            menu_valido = 0;
            valido = 0;
        }

    } while (final == 1);

    printf("\nADIOS, QUE TENGA BUEN DIA\n\n");

    return 0;
}

void DEPOSITO(struct BANCO *depo)
{
    int monto;

    printf("\nINGRESE EL MONTO A DEPOSITAR: ");
    scanf("%i", &monto);
    while ((monto < 0) || (monto > 50000))
    {
        printf("\nEL MONTO NO PUEDE SER NEGATIVO O MAYOR A 50 MIL\nVUELVA A INGRESARLO: ");
        scanf("%i", &monto);
    }

    if (monto == 0)
    {
        printf("\nOPERACION CANCELADA\n");
    }
    else
    {
        printf("\nOPERACION REALIZADA\n");
        depo[pos].saldo += monto;

        depo[pos].arr_opera[depo[pos].mov][0] = depo[pos].mov + 1; // guardar numero de movimiento
        depo[pos].arr_opera[depo[pos].mov][1] = monto;             // guardar monto de la operacion
        depo[pos].mov++;                                           // guarda el numero de mov de CADA CLIENTE
    }
}

void EXTRAER(struct BANCO *extra)
{
    int monto;

    printf("\nINGRESE EL MONTO A EXTRAER: ");
    scanf("%i", &monto);
    while ((monto < 0) || (monto > 50000))
    {
        printf("\nEL MONTO NO PUEDE SER NEGATIVO O MAYOR A 50 MIL\nVUELVA A INGRESARLO: ");
        scanf("%i", &monto);
    }

    if (monto == 0)
    {
        printf("\nOPERACION CANCELADA\n");
    }
    else
    {
        if (extra[pos].saldo > monto) // saldo mayor a extraccion
        {
            printf("\nOPERACION REALIZADA\n");
            extra[pos].saldo -= monto;

            extra[pos].arr_opera[extra[pos].mov][0] = extra[pos].mov + 1;
            extra[pos].arr_opera[extra[pos].mov][1] = monto * -1;
            extra[pos].mov++;
        }
        else
        {
            printf("\nSALDO INSUFICIENTE\n");
            extra[pos].operaciones++; // para que no reste operacion si no tiene saldo
        }
    }
}

void CONSULTA_SALDO(struct BANCO *consulta)
{
    printf("\nSU SALDO ES DE $%i\n", consulta[pos].saldo);
}

void TRANSFERENCIA(struct BANCO *mover)
{
    int numero, cantidad, lugar;
    printf("\nINGRESE EL NUMERO DE CUENTA A LA QUE QUIERE TRASFERIR: ");
    scanf("%i", &numero);
    for (i = 0; i < 10; i++)
    {
        if (numero != mover[pos].numero_cuenta) // validamos que no transfiera a su propia cuenta
        {
            if (mover[i].numero_cuenta == numero)
            {
                lugar = i; // guarda si se encuentra una cuenta que coincida con el num que dimos
                i = 9;
                printf("INGRESE LA CANTIDAD QUE QUIERE TRANSFERIR: ");
                scanf("%i", &cantidad);
                while (cantidad < 0)
                {
                    printf("\nLA CANTIDAD NO PUEDE SER MENOR A 0\n");
                    scanf("%i", &cantidad);
                }

                if (cantidad != 0)
                {
                    if (mover[pos].saldo >= cantidad)
                    {
                        mover[pos].saldo -= cantidad;   // en nuestro saldo se quita la cantidad
                        mover[lugar].saldo += cantidad; // en el saldo del destino se le agrega la cantidad
                        printf("\nTRANSFERENCIA EXITOSA\n");

                        mover[pos].arr_opera[mover[pos].mov][0] = mover[pos].mov + 1;
                        mover[pos].arr_opera[mover[pos].mov][1] = cantidad * -1;
                        mover[pos].mov++;

                        // NO LE REGISTRA LA OPERACION AL DESTINATARIO

                        mover[lugar].arr_opera[mover[lugar].mov][0] = mover[lugar].mov + 1;
                        mover[lugar].arr_opera[mover[lugar].mov][1] = cantidad;
                        mover[lugar].mov++;

                        // printf("\n CUENTA 100 = %i", mover[lugar].saldo);
                    }
                    else
                    {
                        printf("\nNO TIENE SALDO SUFICIENTE\n");
                    }
                }
                else
                {
                    printf("\nOPERACION CANCELADA\n");
                }
            }
            else
            {
                if ((i == 9) && (mover[9].numero_cuenta != numero))
                {
                    printf("\nNO SE ENCONTRO EL NUMERO DE CUENTA\n");
                }
            }
        }
        else
        {
            printf("\nNO PUEDE TRANSFERIR A SU PROPIA CUENTA\n");
            i = 9;
        }
    }
}

void OPCION_5(struct BANCO *mirar)
{
    if (mirar[pos].mov != 0)
    {
        printf("\nOPERACION     MONTO");
        for (i = 0; i < mirar[pos].mov; i++)
        {
            printf("\n    %i         %i", mirar[pos].arr_opera[i][0], mirar[pos].arr_opera[i][1]);
        }
    }

    printf("\nOPERACIONES RESTANTES = %i", mirar[pos].operaciones);
    printf("\nSU SALDO ES DE $%i\n", mirar[pos].saldo);
}

void CARGA(struct BANCO *clientes)
{
    clientes[0].numero_cuenta = 999;
    strcpy(clientes[0].contrasena, "999");
    strcpy(clientes[0].nombre, "Alan Wake");
    clientes[0].saldo = 0;
    strcpy(clientes[0].estado, "ACTIVO");
    clientes[0].intentos = 0;
    clientes[0].operaciones = 10;
    clientes[0].mov = 0;

    clientes[1].numero_cuenta = 100;
    strcpy(clientes[1].contrasena, "usuario100");
    strcpy(clientes[1].nombre, "Gabriel Sarmiento");
    clientes[1].saldo = 0;
    // strcpy(clientes[1].estado, "BLOQUEADO");
    strcpy(clientes[1].estado, "ACTIVO");
    clientes[1].intentos = 0;
    clientes[1].operaciones = 10;
    clientes[1].mov = 0;

    clientes[2].numero_cuenta = 200;
    strcpy(clientes[2].contrasena, "usuario200");
    strcpy(clientes[2].nombre, "Fernando Malardo");
    clientes[2].saldo = 200;
    strcpy(clientes[2].estado, "ACTIVO");
    clientes[2].intentos = 0;
    clientes[2].operaciones = 10;
    clientes[2].mov = 0;

    clientes[3].numero_cuenta = 300;
    strcpy(clientes[3].contrasena, "usuario300");
    strcpy(clientes[3].nombre, "Frank Cabra");
    clientes[3].saldo = 300;
    strcpy(clientes[3].estado, "ACTIVO");
    clientes[3].intentos = 0;
    clientes[3].operaciones = 10;
    clientes[3].mov = 0;

    clientes[4].numero_cuenta = 400;
    strcpy(clientes[4].contrasena, "usuario400");
    strcpy(clientes[4].nombre, "Juan Gutierrez");
    clientes[4].saldo = 60000;
    strcpy(clientes[4].estado, "ACTIVO");
    clientes[4].intentos = 0;
    clientes[4].operaciones = 10;
    clientes[4].mov = 0;

    clientes[5].numero_cuenta = 500;
    strcpy(clientes[5].contrasena, "usuario500");
    strcpy(clientes[5].nombre, "Cristiano Messi");
    clientes[5].saldo = 45000;
    strcpy(clientes[5].estado, "ACTIVO");
    clientes[5].intentos = 0;
    clientes[5].operaciones = 10;
    clientes[5].mov = 0;

    clientes[6].numero_cuenta = 600;
    strcpy(clientes[6].contrasena, "usuario600");
    strcpy(clientes[6].nombre, "Gaston");
    clientes[6].saldo = 100000;
    strcpy(clientes[6].estado, "ACTIVO");
    clientes[6].intentos = 0;
    clientes[6].operaciones = 10;
    clientes[6].mov = 0;

    clientes[7].numero_cuenta = 700;
    strcpy(clientes[7].contrasena, "usuario700");
    strcpy(clientes[7].nombre, "Mateo Descenso");
    clientes[7].saldo = 1234890;
    strcpy(clientes[7].estado, "ACTIVO");
    clientes[7].intentos = 0;
    clientes[7].operaciones = 10;
    clientes[7].mov = 0;

    clientes[8].numero_cuenta = 800;
    strcpy(clientes[8].contrasena, "usuario800");
    strcpy(clientes[8].nombre, "Juan Gutierrez");
    clientes[8].saldo = 60000;
    strcpy(clientes[8].estado, "ACTIVO");
    clientes[8].intentos = 0;
    clientes[8].operaciones = 10;
    clientes[8].mov = 0;

    clientes[9].numero_cuenta = 900;
    strcpy(clientes[9].contrasena, "usuario900");
    strcpy(clientes[9].nombre, "Peter Kaka");
    clientes[9].saldo = 95000;
    strcpy(clientes[9].estado, "ACTIVO");
    clientes[9].intentos = 0;
    clientes[9].operaciones = 10;
    clientes[9].mov = 0;
}
