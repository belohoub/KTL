#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "rh.h"
#include "temp.h"

int main(int argc, char *argv[])
{ 
    printf("This is main() BEGIN\n");
    
    while(1) {
        
        printf("Enviromental parameters: \n");
        
#ifdef MODULE_RH
        printRH();    
#endif
        
#ifdef MODULE_TEMP
        printTemp();    
#endif
    
        sleep(10);
        
        printf("\n");
    }
    
    printf("This is main() END\n");
}
