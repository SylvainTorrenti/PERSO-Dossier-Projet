// ------------------------------------------------------------------------
//		Ce programme permet d'afficher sur la console les Nombres Impairs
// ------------------------------------------------------------------------

// ---- Fichiers à inclure
#include <stdio.h>
#include <windows.h>

// -------------------------------------------------------
//		Programme Principal
// -------------------------------------------------------
int main()
{
	int i;
	printf("\t\t\t\t\t\tDebut Processus Impair\n");
	for (i = 1; i < 100; i = i + 2)
	{
		printf("\t\t\t\t\t\t%d \n", i);
		Sleep(1000);
	}
	printf("\t\t\t\t\t\tFIN Processus Impair\n");
	return(0);
}

