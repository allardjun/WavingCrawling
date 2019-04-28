/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

double velocityPromotion;

/* requires globals: V (any value), dBAMdt (any value), Bc, all ODE params  */

double *odeDefn(double *Bi, double *Ai, double *Mi);
void VFunc(double *Bi);
void VFuncPolyPromote(double *Bi, double *Ai, double *Mi);

double GammaFunc(double *Bi, double *Ai, double *Mi);

double *odeDefn(double *Bi, double *Ai, double *Mi)
{
	if (!polyPromoteTF)
		VFunc(Bi);
	else
		VFuncPolyPromote(Bi,Ai,Mi);
	
	*(dBAMdt+0) = 1/epsilon*((1+etaB*V)-(*Bi)/(1+(*Ai)*(*Bi)/(1+(*Mi)+K*(*Bi))));
	*(dBAMdt+1) = delta - (1+etaA*V+etaM*(*Mi)*V)*(*Ai)/(1+(*Mi)+K*(*Bi)); /* with cytosolic flow away*/
	if(1)
		*(dBAMdt+2) = (R*(*Bi) - (theta+etaM*V)*(*Mi));

	if(0)
		*(dBAMdt+2) = (MConst - (*Mi))*0.1;

	
	/*printf("*(dBAMdt+0) = %lf", 1/epsilon*((1+etaB*V)-(*B)/(1+(*A)*(*B)/(1+(*M)+K*(*B)))));*/
	
	return dBAMdt;
}

void VFunc(double *Bi)
{
	 if ((*Bi)>(*Bc))
		V = ( 1 - pow((*Bc)/(*Bi),8) );
	else
		V = 0;
	
	/* V = 0.5*(1+tanh(10*(B-Bc))).*( 1 - (Bc./B).^8 ).*( B>Bc ); */

	/*V = 0.5*(1+tanh(10*( (*Bi) - (*Bc))))*( 1 - pow((*Bc)/(*Bi),8) );*/
	
}

void VFuncPolyPromote(double *Bi, double *Ai, double *Mi)
{
	if ((*Bi)>(*Bc))
		V = (1+alpha*(*Ai)*(*Bi)/(1+(*Mi)+K*(*Bi)))*( 1 - pow((*Bc)/(*Bi),8) );
	else
		V = 0;

}

double GammaFunc(double *Bi, double *Ai, double *Mi)
{
	return 1/epsilon*( (*Bi)*(*Bi)*K*( (*Ai)+K ) +  2*(*Bi)*K*(1+(*Mi)) + (1+(*Mi))*(1+(*Mi))  )/
		pow( (1+(*Ai)*(*Bi) + (*Bi)*K + (*Mi)*(*Mi)), 2);
	
	/*return 1/(epsilon*(1+(*Ai)*(*Bi)/(1+(*Mi)+K*(*Bi)))) ;*/
}