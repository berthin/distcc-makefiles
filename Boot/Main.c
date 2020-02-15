#include <stdio.h>
#include "Print.h"

int main()
{
    int one_int;
    printf("One integer: ");
    scanf("%d", &one_int);
    Print_OneInt(one_int);
    return 0;
}
