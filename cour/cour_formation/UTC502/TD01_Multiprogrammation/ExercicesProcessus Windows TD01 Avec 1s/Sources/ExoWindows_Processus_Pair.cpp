// ------------------------------------------------------------------------
//		Ce programme permet d'afficher sur la console les Nombres pairs
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
	printf("\t-> Debut Processus Pair\n");
	for (i = 0; i < 101; i = i + 2)
	{
		printf("\t%d \n", i);
		Sleep(1000);
	}
	printf("\t-> FIN Processus Pair\n");
	return(0);
}

