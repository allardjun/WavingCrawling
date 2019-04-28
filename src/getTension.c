/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

void getTension(  );


void getTension(  )
{
	/* --- Constant tension --- */
	/*(*Bc) = Bc0;*/
	
	double Lg;
	int tightCounter;
	
	/* --- Switch tension --- */
	
	if (0)
	{
		(*Bc) = Bc0;
		for(ix=0; ix<=(*nx)-1; ix++) 
			if( *(B+ix) > Bc0*(1+E1) )
			{
				
				(*Bc) = Bc0*(1+E1);

				tightCounter++;
				ix = (*nx)+2;
				/*printf("tight (*Bc)=%lf\n", (*Bc));*/
				
			}
		
		if(0)
		{
			if(tightCounter > 0) /*0.1*dx) */
				(*Bc) = Bc0*(1+E1);
		}
	}
	
	/* --- whatever was in ipder --- */
	
	if (1)
	{
		Lg=0;
		(*Bc)=Bc0*(1+E1);
		for(ix=0; ix<=(*nx)-1; ix++)
		{
			if (!polyPromoteTF)
				VFunc((B+ix));
			else
				VFuncPolyPromote(B+ix,A+ix,M+ix);
			Lg +=  V*dx;
		}
		
		(*Bc) = Bc0 + Bc0*E1*0.5*(1+tanh(1/wTCusp*(Lg-0.5*LgMin)));
	}
	
	return;
}


