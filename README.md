# Model of waving behavior at the leading edge of crawling cells

Full model description is published in: Barnhart, E., Allard, J., Mogilner, A., Theriot, J., Adhesion-dependent wave generation in crawling cells. Current Biology 27: 27:38 (2017).

## Basic usage

* In the folder /src/, open Matlab script __doPdeSingle.m__.

* Create a folder /runs/ in the same directory as the repository. Large files will be deposited here so it can be left out of the repository sync if desired.  

* Edit the line __runName = 'testrun1';__ to a desired runName.

* Run __doPdeSingle.m__. This will create a directory in /runs/ with the runName, perform a single execution of the model, and run analysis of the results that will generate plots.


## Requirements

* Matlab 2018a

* Mex requires a C compiler
