/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

#define twister genrand_real3()

#include "mex.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include "twister.c" 
#include "getParams.c"

#define NXMAX 10000
#define polyPromoteTF 1

double *B, *A, *M, *Bc; /* dynamic variables */
double dBdtTransport[NXMAX]; 
double *dBAMdt; /* aux dynamic variable  */
double V; /* aux variables */

FILE *fVisualize, *fTable11;
char command[100], runName[100];

const mxArray *pODE, *pPDE, *pNumerics;
int ix, nt, nDump, prematureReturnTF, dumpPeriodInt;
double t;
double dBAMdt_variable[3], Bc_variable;
double GammaArray[NXMAX];


double *nx, *dt; 


#include "odeDefn.c"
#include "transport.c"
#include "getTension.c"






/* prototypes */
void dataCollection();

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	int nFile, iFile;
	
	int nxInt;
	
	double *VArray, *BAllTime, *BcArray;
	double *MAllTime, *AAllTime;
	
	Bc = &Bc_variable;
	
	
	
	/* input variables */
	BAllTime  = mxGetPr(prhs[0]);
	BcArray  = mxGetPr(prhs[1]);
	
	/* get nx and nFile length */
    nxInt = mxGetM(prhs[0]);
	nFile = mxGetN(prhs[0]);
	
	/* printf("nxInt=M=%d, nFile=N=%d\n", nxInt, nFile); */
	
	/* output variable */
	plhs[0] = mxCreateDoubleMatrix(nxInt,nFile, mxREAL);
	VArray = mxGetPr(plhs[0]);
	
	
	if(!polyPromoteTF)
	{
		for(iFile=0; iFile<nFile; iFile++)
		{
			(*Bc) = *(BcArray+iFile);
			for(ix=0; ix<=nxInt-1; ix++) /* loop through space */
			{
				VFunc( (BAllTime+iFile*nxInt+ix) );
				*(VArray+iFile*nxInt+ix) = V; 
			}
		}
	}
	else
	{
		AAllTime  = mxGetPr(prhs[2]);
		MAllTime  = mxGetPr(prhs[3]);

		for(iFile=0; iFile<nFile; iFile++)
		{
			(*Bc) = *(BcArray+iFile);
			for(ix=0; ix<=nxInt-1; ix++) /* loop through space */
			{
				
				VFuncPolyPromote( (BAllTime+iFile*nxInt+ix), (AAllTime+iFile*nxInt+ix) , (MAllTime+iFile*nxInt+ix)  );
				*(VArray+iFile*nxInt+ix) = V; 
			}
		}	
	}
	
	return;
	
}
