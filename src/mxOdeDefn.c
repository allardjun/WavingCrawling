/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

#include "mex.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include "getParams.c"

#define polyPromoteTF 0


double *B, *A, *M, *Bc; /* dynamic variables */
double *dBAMdt; /* output */
double V; /* aux variables */

#include "odeDefn.c"

#define point_pODE prhs[4]

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	const mxArray *pODE;
	
	/* input variables */
	B = mxGetPr(prhs[0]);
	A = mxGetPr(prhs[1]);
	M = mxGetPr(prhs[2]);
	Bc = mxGetPr(prhs[3]);
	pODE = prhs[4];
 
	/* printf("N=%d, nmax=%d\n", N, nmax); */
	
    /* Create matricies for the return arguments */ 
    plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL);
    
    dBAMdt = mxGetPr(plhs[0]);
	
	/* get parameters into global variable */
	getParamsODE(pODE);

	/* functions described explicitly in odeDefn.c */
	dBAMdt = odeDefn(B,A,M);
	
	return;

}
