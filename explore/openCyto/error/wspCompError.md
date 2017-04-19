
Previously I was using compensation matrix from the wsp file to plot/analyze manual gates (compensation for automatic gates always is pulled from the .fcs file)

Getting an error with the new .fcs files when loading from .wsp, has anything changed?

Comp from .wsp, error

```r
 gs <-
        parseWorkspace(
          ws, #WSP file 
          path = inputFCSDir, #FCS file directory
          name = 1, #sample group
          subset = eval(fileToLoad), #load single fcs file
          isNcdf = FALSE #not memory mapped
        )
```
```        
#result        

Parsing 1 samples
windows version of flowJo workspace recognized.
version X
Creating flowSet...
loading data: /Volumes/Beta/data/flow/fcsNewMachine//PBMC-HRS PILOT 2-group2_HRS024-D24_029.fcs
Compensating
Error in FUN(newX[, i], ...) : 
  channels mismatched between compensation and flow data!        

```

Comp from .fcs, works

```r

gs <-
        parseWorkspace(
          ws, #WSP file 
          path = inputFCSDir, #FCS directory
          name = 1, #sample group
          subset = eval(fileToLoad), #load single fcs file
          isNcdf = FALSE, #not memory mapped
          compensation = comp #use compensation matrix from fcs file
        )
```
```
#result
   Parsing 1 samples
windows version of flowJo workspace recognized.
version X
Creating flowSet...
loading data: /Volumes/Beta/data/flow/fcsNewMachine//PBMC-HRS PILOT 2-group2_HRS024-D24_029.fcs
Compensating
gating ...
done!
```     