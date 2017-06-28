with clean local lib,  really all for ncdfflowset


```
module load R/3.3.3
module load gcc/6.1.0
module load hdf5/hdf5-1.8.9-intel
```

## GCC version
```
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/panfs/roc/msisoft/gcc/6.1.0/bin/../libexec/gcc/x86_64-pc-linux-gnu/6.1.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with: ./configure --prefix=/panfs/roc/itascasoft/gcc/6.1.0 --with-gmp=/panfs/roc/itascasoft/gmp/6.1.0_gcc6.1.0 --with-mpfr=/panfs/roc/itascasoft/mpfr/3.1.4-p1_gcc6.1.0 --with-mpc=/panfs/roc/itascasoft/mpc/1.0.3_gcc6.1.0 --with-isl=/panfs/roc/itascasoft/isl/0.16.1_gcc6.1.0 --enable-bootstrap --disable-multilib
Thread model: posix
gcc version 6.1.0 (GCC) 

```

```
 R CMD INSTALL ncdfFlow_2.22.0.tar.gz --configure-args="--with-hdf5='/panfs/roc/msisoft/hdf5/hdf5-1.8.9-intel'"q
```


```


source("https://bioconductor.org/biocLite.R")
biocLite("openCyto")
#biocLite("ncdfFlow")
biocLite("flowCore") 
biocLite("ggcyto") X
biocLite("gridExtra")
 biocLite("CytoML")
biocLite("flowAI")
biocLite("flowDensity")
```
 biocLite("data.table") X

```
export HDF5="/home/pankrat2/public/bin/hdf5/hdf5-1.10.1-linux-centos7-x86_64-gcc485-shared"
export  PATH=$PATH:${HDF5}/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HDF5}/lib
```
