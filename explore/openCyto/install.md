with clean local lib,  really all for ncdfflowset


```
module load R/3.4.0
module load gcc
R CMD INSTALL ncdfFlow_2.22.0.tar.gz --configure-args="--with-hdf5='/home/pankrat2/public/bin/hdf5/hdf5-1.10.1-linux-centos7-x86_64-gcc485-shared/'"
```


```


source("https://bioconductor.org/biocLite.R")
biocLite("openCyto")

+# biocLite("flowCore") X
 +# biocLite("data.table") X
 +# biocLite("ggcyto") X
 +# biocLite("gridExtra")
 +# biocLite("CytoML")
 +# biocLite("flowAI")
```

```
export HDF5="/home/pankrat2/public/bin/hdf5/hdf5-1.10.1-linux-centos7-x86_64-gcc485-shared"
export  PATH=$PATH:${HDF5}/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HDF5}/lib
```
