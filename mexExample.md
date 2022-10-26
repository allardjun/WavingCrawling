# Example of mex (Matlab C integration)

`mex` allows a function written in C to be called from a matlab m-file. 

An example is in `src/doOdeSingle.m`. 
This calls a function `mxOdeDefn()`. 
The function `mxOdeDefn()` was created in the file `mxOdeDefn.c`.

To execute the example:

- In Matlab, run `mex mxOdeDefn.c`. This will create a file called `mxOdeDefn.mexXXXX` where "XXXX" depends on your local cpu architecture.
- In Matlab, run `doOdeSingle.m`. 

