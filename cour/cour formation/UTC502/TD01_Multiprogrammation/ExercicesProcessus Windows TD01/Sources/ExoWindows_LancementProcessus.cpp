// ======================================================================= 
//     Programme Affichage des Nombres de 1 à 100 
//     en lancant l'exécution de deux processus :
//     - un processus qui affiche les nombres pairs
//     - un processus qui affiche les nombres impairs
// ----------------------------------------------------------------------- 
//     Ecrit le								par :
// ----------------------------------------------------------------------- 
//     Modifié le							par :
// ========================================================== data C ===== 

// ----------------------------------------------------------------------- 
//     Include                      
// ----------------------------------------------------------------------- 
#include <stdio.h>
#include <tchar.h>
#include <direct.h>
#include "windows.h"

// ======================================================================= 
//     Main                      
// ======================================================================= 
int main()
{
	LPTSTR szCmdline;
	STARTUPINFO si, si2;
	PROCESS_INFORMATION pi, pi2;
	// ----------------------------------------------------------------------- 
	//     Initialisation                      
	// ----------------------------------------------------------------------- 

	printf("Debut du module principal \n\n");

	// ---- Mise a zero des structures STARTUPINFO & PROCESS_INFORMATION                      
	ZeroMemory(&si, sizeof(si));
	ZeroMemory(&si2, sizeof(si2));
	si.cb = sizeof(si);
	si2.cb = sizeof(si2);
	ZeroMemory(&pi, sizeof(pi));
	ZeroMemory(&pi2, sizeof(pi2));

	// ----------------------------------------------------------------------- 
	//     Creation du Processus Pair                      
	// ----------------------------------------------------------------------- 
	printf("Creation du Processus Pair \n");
	szCmdline = _tcsdup(TEXT("Pair.exe"));
	if (!CreateProcessW(NULL,				// No module name (use command line).
						szCmdline,			// Command line. 
						NULL,				// Process handle not inheritable. 
						NULL,				// Thread handle not inheritable. 
						FALSE,				// Set handle inheritance to FALSE. 
						0,					// No creation flags. 
						NULL,				// Use parent's environment block. 
						NULL,				// Use parent's starting directory. 
						&si,				// Pointer to STARTUPINFO structure.
						&pi)				// Pointer to PROCESS_INFORMATION structure.
		)
	{
		printf("CreateProcess en erreur (%d)\n", GetLastError());
	}
	// ----------------------------------------------------------------------- 
	//     Creation du Processus Impair                     
	// ----------------------------------------------------------------------- 
	printf("Creation du Processus Impair \n");
	szCmdline = _tcsdup(TEXT("Impair.exe"));
	if (!CreateProcessW(NULL,				// No module name (use command line). 
						szCmdline,			// Command line. 
						NULL,				// Process handle not inheritable. 
						NULL,				// Thread handle not inheritable. 
						FALSE,				// Set handle inheritance to FALSE. 
						0,					// No creation flags. 
						NULL,				// Use parent's environment block. 
						NULL,				// Use parent's starting directory. 
						&si2,				// Pointer to STARTUPINFO structure.
						&pi2)				// Pointer to PROCESS_INFORMATION structure.
		)
	{
		printf("CreateProcess en erreur (%d)\n", GetLastError());
	}
	
	// ---- on attend la fin des Processus
	WaitForSingleObject(pi.hProcess,INFINITE);
	WaitForSingleObject(pi2.hProcess, INFINITE);
	
	getchar();

	return(0);
}