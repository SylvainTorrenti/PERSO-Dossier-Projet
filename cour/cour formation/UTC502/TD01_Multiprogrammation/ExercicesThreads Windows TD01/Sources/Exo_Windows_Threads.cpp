// ======================================================================= 
//     Programme Creation de threads avec une fonction pour chaque thread                     
// ----------------------------------------------------------------------- 
//     Ecrit le								par :
// ----------------------------------------------------------------------- 
//     Modifié le							par :
// ========================================================== data C ===== 
// ----------------------------------------------------------------------- 
//     Include                      
// ----------------------------------------------------------------------- 
#include <stdio.h>
#include <windows.h>

// ----------------------------------------------------------------------- 
//     define                      
// ----------------------------------------------------------------------- 

// ----------------------------------------------------------------------- 
//     Espace de données Global                                 
// ----------------------------------------------------------------------- 

// ----------------------------------------------------------------------- 
//     Prototye des fonctions utilisées                      
// ----------------------------------------------------------------------- 
void Pair();
void Impair();

// ======================================================================= 
//     Main                      
// ======================================================================= 
int main()
{
	DWORD ThreadId1, ThreadId2;			// necessaire pour la creation d'un thread
	HANDLE hdl_thread1, hdl_thread2;
	bool w_bOK;
	// ----------------------------------------------------------------------- 
	//     Initialisation                      
	// ----------------------------------------------------------------------- 
	
	while (true) {
		printf("Debut du programme principal \n");
		w_bOK = true;
		// ---- On démarre le thread. ThreadId est l'identifiant du thread
		//      ThreadId ne nous est d'aucune utilité dans cet exmple car le thread
		//      se termine de lui même
		// ------------------------------------------------------------------------
		//		Creation du Thread 1 PAIR
		// ------------------------------------------------------------------------
		hdl_thread1 = CreateThread(NULL, NULL,(LPTHREAD_START_ROUTINE) Pair, NULL, NULL, &ThreadId1);
		if (hdl_thread1 == NULL)
		{
			printf("le thread 1 PAIR n'a pu etre lance\n");
			w_bOK = false;
			break;
		}
		// ------------------------------------------------------------------------
		//		Creation du Thread 2 IMPAIR
		// ------------------------------------------------------------------------

		hdl_thread2 = CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE) Impair, NULL, NULL, &ThreadId2);
		if (hdl_thread2 == NULL)
		{
			printf("le thread 2 IMPAIR n'a pu etre lance\n");
			w_bOK = false;
			break;
		}

		// ---- on attend  que les threads se soient exécutés
		WaitForSingleObject(hdl_thread1, INFINITE);
		WaitForSingleObject(hdl_thread2, INFINITE);

		break;	// pour sortir de la boucle sans fin !!!
	}

	ExitProcess(0);
	return 0;
}


// ======================================================================= 
//     Fonction Pair                 
// ======================================================================= 
void Pair()
{
	int Num;
	printf("le thread 1 PAIR est lance\n");
	for (Num = 0; Num < 100; Num = Num + 2)
	{
		printf("%2d\n", Num);
		Sleep(500);
	}
}

// ======================================================================= 
//     Fonction Impair                 
// ======================================================================= 
void Impair()
{
	int Num;
	printf("Le Thread 2 IMPAIR est lance\n");
	for (Num = 1; Num < 100; Num = Num + 2)
	{
		printf("\t\t\t%2d\n", Num);
		Sleep(500);
	}
}

