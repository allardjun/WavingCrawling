/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

double R, delta, epsilon, etaB, etaA, etaM, theta, K, alpha, Bc0, MConst; /* parameters */
double L, E1, E2, XiB, XiA, XiM, DB;
double dx, tMax, ntMax, dumpPeriod, repeatableTF, wTCusp, LgMin, smallDumpPeriod;

void getParamsODE( const mxArray *pODE );
void getParamsPDE( const mxArray *pPDE );
void getParamsNumerics( const mxArray *pNumerics );

void getParamsODE( const mxArray *pODE )
{
	/* get parameters into global variable */
	R = *( (double *)mxGetData(mxGetField(pODE, 0, "R")) );
	delta = *( (double *)mxGetData(mxGetField(pODE, 0, "delta")) );
	epsilon = *( (double *)mxGetData(mxGetField(pODE, 0, "epsilon")));
	etaB = *( (double *)mxGetData(mxGetField(pODE, 0, "etaB")));
	etaA = *( (double *)mxGetData(mxGetField(pODE, 0, "etaA")));
	etaM = *( (double *)mxGetData(mxGetField(pODE, 0, "etaM")));
	theta = *( (double *)mxGetData(mxGetField(pODE, 0, "theta")));
	K = *( (double *)mxGetData(mxGetField(pODE, 0, "K")));
	alpha = *( (double *)mxGetData(mxGetField(pODE, 0, "alpha")));
	Bc0 = *( (double *)mxGetData(mxGetField(pODE, 0, "Bc0")));
	MConst = *( (double *)mxGetData(mxGetField(pODE, 0, "MConst")));

	return;
}

void getParamsPDE( const mxArray *pPDE )
{
	/* get parameters into global variable */
	L = *( (double *)mxGetData(mxGetField(pPDE, 0, "L")) );
	E1 = *( (double *)mxGetData(mxGetField(pPDE, 0, "E1")) );
	E2 = *( (double *)mxGetData(mxGetField(pPDE, 0, "E2")));
	DB = *( (double *)mxGetData(mxGetField(pPDE, 0, "DB")));
	XiB = *( (double *)mxGetData(mxGetField(pPDE, 0, "XiB")));
	XiA = *( (double *)mxGetData(mxGetField(pPDE, 0, "XiA")));
	XiM = *( (double *)mxGetData(mxGetField(pPDE, 0, "XiM")));
	
	return;
}

void getParamsNumerics( const mxArray *pNumerics )
{
	/* get parameters into global variable */
	dx = *( (double *)mxGetData(mxGetField(pNumerics, 0, "dx")) );
	tMax = *( (double *)mxGetData(mxGetField(pNumerics, 0, "tMax")) );
	ntMax = *( (double *)mxGetData(mxGetField(pNumerics, 0, "ntMax")));
	dumpPeriod = *( (double *)mxGetData(mxGetField(pNumerics, 0, "dumpPeriod")));
	smallDumpPeriod = *( (double *)mxGetData(mxGetField(pNumerics, 0, "smallDumpPeriod")));
	repeatableTF = *( (double *)mxGetData(mxGetField(pNumerics, 0, "repeatableTF")));
	wTCusp = *( (double *)mxGetData(mxGetField(pNumerics, 0, "wTCusp")));
	LgMin = *( (double *)mxGetData(mxGetField(pNumerics, 0, "LgMin")));

	return;
}
