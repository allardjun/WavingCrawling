/*** Jun (Mogilner Lab) jun@math.ucdavis.edu                    ***/

void transport(  )
{
	
	/*double tmpConserve;*/
	
	if (0) /* --- closed BCs, constant diffusion --- */
	{
		
		dBdtTransport[0] = DB*( (*(B+1) - *(B+0))/(dx*dx) );
		
		/* PDE forward Euler step */
		for(ix=1; ix<=(*nx)-2; ix++) /* loop through space */
			dBdtTransport[ix] = DB*( (*(B+ix-1) - 2*(*(B+ix)) + *(B+ix+1) )/(dx*dx) );
		
		dBdtTransport[(int)(*nx)-1] = DB*( (*(B+(int)(*nx)-2) - *(B+(int)(*nx)-1))/(dx*dx) );
		
	}
	
	if (1) 	/* --- closed BCs, varying diffusion --- */
	{
		
		for(ix=0; ix<=(*nx)-1; ix++)
			GammaArray[ix] = GammaFunc((B+ix), (A+ix), (M+ix));
		
		dBdtTransport[0] = DB*( (GammaArray[1]*(*(B+1)) - GammaArray[0]*(*(B+0)))/(dx*dx) );
		
		/* PDE forward Euler step */
		for(ix=1; ix<=(*nx)-2; ix++) /* loop through space */
			dBdtTransport[ix] = DB*( (GammaArray[ix-1]*(*(B+ix-1)) - 2*GammaArray[ix]*(*(B+ix)) + GammaArray[ix+1]*(*(B+ix+1)) )/(dx*dx) );
		
		dBdtTransport[(int)(*nx)-1] = DB*( (GammaArray[(int)(*nx)-2]*(*(B+(int)(*nx)-2)) - GammaArray[(int)(*nx)-1]*(*(B+(int)(*nx)-1)))/(dx*dx) );
	}
	
	if (0) 	/* --- periodic BCs, varying diffusion --- */
	{
		
		for(ix=0; ix<=(*nx)-1; ix++)
			GammaArray[ix] = GammaFunc((B+ix), (A+ix), (M+ix));
		
		dBdtTransport[0] = DB*( (GammaArray[(int)(*nx)-1]*(*(B+(int)(*nx)-1)) - 2*GammaArray[0]*(*(B+0)) + GammaArray[0+1]*(*(B+0+1)) )/(dx*dx) );
		
		/* PDE forward Euler step */
		for(ix=1; ix<=(*nx)-2; ix++) /* loop through space */
			dBdtTransport[ix] = DB*( (GammaArray[ix-1]*(*(B+ix-1)) - 2*GammaArray[ix]*(*(B+ix)) + GammaArray[ix+1]*(*(B+ix+1)) )/(dx*dx) );
		
		dBdtTransport[(int)(*nx)-1] = DB*( (GammaArray[(int)(*nx)-1-1]*(*(B+(int)(*nx)-1-1)) - 2*GammaArray[(int)(*nx)-1]*(*(B+(int)(*nx)-1)) + GammaArray[0]*(*(B+0)) )/(dx*dx) );
		
	}
	
	
	
	/* debug */
	/*tmpConserve = 0;
	for(ix=0; ix<=(*nx)-1; ix++)
		tmpConserve += dBdtTransport[ix];
	
	if (tmpConserve*tmpConserve > SMALL)
		printf("sum dBdtTransport=%lf\n", tmpConserve);*/
	
	return;
}


