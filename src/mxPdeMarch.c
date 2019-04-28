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
#define SMALL 1e-5
#define polyPromoteTF 1

double *B, *A, *M, *Bc; /* dynamic variables */
double dBdtTransport[NXMAX]; 
double *dBAMdt; /* aux dynamic variable  */
double V; /* aux variables */

FILE *fVisualize, *fTable11;
char command[100], runName[100];

const mxArray *pODE, *pPDE, *pNumerics;
int ix, nt, nDump, prematureReturnTF, dumpPeriodInt, smallDumpPeriodInt;
double t;
double dBAMdt_variable[3], Bc_variable;
double GammaArray[NXMAX];

double *nx, *dt; 

#include "odeDefn.c"
#include "transport.c"
#include "getTension.c"



/* prototypes */
void dataCollection();
void smallDataCollection();


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	
	dBAMdt = dBAMdt_variable;
	Bc = &Bc_variable;
	
	/* input variables */
	B  = mxGetPr(prhs[0]);
	A  = mxGetPr(prhs[1]);
	M  = mxGetPr(prhs[2]);
	nx = mxGetPr(prhs[3]);
	dt = mxGetPr(prhs[4]); 
	
	pODE      = prhs[5];
	pPDE      = prhs[6];
	pNumerics = prhs[7];
		
	/* runName (aka runDir) */
	
	mxGetString(prhs[8], runName, 100 );
	
	printf("runName=%s\n", runName);
	
	/* get parameters into global variable */
	getParamsODE(pODE);
	getParamsPDE(pPDE);
	getParamsNumerics(pNumerics);
	
	// RNG seeding
	RanInit(repeatableTF); /* set the argumant to 1 for a repeatable (debugging) run. */
	
	dumpPeriodInt = (int)dumpPeriod;
	smallDumpPeriodInt = (int)smallDumpPeriod;

	/* time loop */
	nt=0;t=0;nDump=0;
	prematureReturnTF = 0;
	while  (nt<ntMax && t<tMax && ~prematureReturnTF)
	{
		/* compute tension */
		getTension();
			
		/* transport model */
		transport();	
		
		/* PDE forward Euler step */
		for(ix=0; ix<=(*nx)-1; ix++) /* loop through space */
		{
			dBAMdt = odeDefn((B+ix),(A+ix),(M+ix));

			*(B+ix) += (*dt)*( *(dBAMdt+0) + dBdtTransport[ix] ) + sqrt((*dt)*XiB)*(*(B+ix))*2*(twister-0.5); 
			*(A+ix) += (*dt)*( *(dBAMdt+1))	                     + sqrt((*dt)*XiA)*(*(A+ix))*2*(twister-0.5);
			*(M+ix) += (*dt)*( *(dBAMdt+2))                      + sqrt((*dt)*XiM)*(*(M+ix))*2*(twister-0.5);
    
			if (*(B+ix)<=0)
				*(B+ix) = SMALL;
			if (*(A+ix)<=0)
				*(A+ix) = SMALL;
			if (*(M+ix)<=0)
				*(M+ix) = SMALL;
			
		} 
	
		/*printf("nt=%d, dumpPeriodInt=%d, (nt mod dumpPeriodInt)=%d\n", nt, dumpPeriodInt, (nt%dumpPeriodInt));*/
		
		/* store data */
		if ((nt%dumpPeriodInt) == 0)
		{
			dataCollection();
			
			nDump++;
			printf("t=%lf\n",t);
		} /* done (big) dump */
		if ((nt%smallDumpPeriodInt) == 0)
		{
			smallDataCollection();
		} /* done small dump */
		

		
		
		nt++;
		t += (*dt);
    
	} /* finished time loop */
	
	
	return;

}

void dataCollection()
{
	/* snapshot */
	sprintf(command, "%s/visual%06d", runName, nDump);
	fVisualize = fopen(command, "w");
	for(ix=0; ix<=(*nx)-1; ix++) /* loop through space */
		fprintf(fVisualize, "%f %f %f\n", *(B+ix), *(A+ix), *(M+ix) );
	fclose(fVisualize);
	
	/* vst table */
	sprintf(command, "%s/table11", runName);
	fTable11 = fopen(command, "a");
	fprintf(fTable11, "%d %f %f\n", nt, t, *Bc );
	fclose(fTable11);
	
	return;

} /* done dataCollection() */


void smallDataCollection()
{

	/* vst table */
	sprintf(command, "%s/table22", runName);
	fTable11 = fopen(command, "a");
	fprintf(fTable11, "%d %f %f\n", nt, t, *Bc );
	fclose(fTable11);
	
	return;
	
} /* done dataCollection() */
