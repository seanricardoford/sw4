FC = xlf
LINKER = mpixlC
CXX = nvcc
RAJA_LOCATION = /usr/workspace/wsb/deg/ramesh/RAJA_053/RAJA/install_ray053
RAJA_LOCATION = /usr/workspace/wsb/deg/ramesh/RAJA_01_24_2018/RAJA/install
RAJA_LOCATION = /usr/workspace/wsb/deg/ramesh/RAJA_053/RAJA/install_053NOMP
RAJA_LOCATION = /usr/workspace/wsb/deg/ramesh/RAJA_01_24_2018/RAJA/install_nomp
EXTRA_FORT_FLAGS = 
LINKFLAGS = 
EXTRA_CXX_FLAGS =  -g -ccbin mpixlC -Xcompiler="-qmaxmem=-1" -std=c++11 --expt-extended-lambda -restrict -arch=sm_60 -I $(CUDA_HOME)/include -I$(RAJA_LOCATION)/include  --x cu -DUSE_NVTX -DRAJA_USE_CUDA -DSW4_CROUTINES -DRAJA_USE_RESTRICT_PTR -DCUDA_CODE -DENABLE_CUDA -dc

EXTRA_CXX_FLAGS2 =  -g -ccbin mpixlC -Xcompiler="-qmaxmem=-1" -std=c++11 --expt-extended-lambda -restrict -arch=sm_60 -I $(CUDA_HOME)/include -I$(RAJA_LOCATION)/include  --x cu -DUSE_NVTX -DRAJA_USE_CUDA -DSW4_CROUTINES -DRAJA_USE_RESTRICT_PTR -DCUDA_CODE -DENABLE_CUDA

EXTRA_LINK_FLAGS = -dc -L /usr/tcetmp/packages/xl/xl-beta-2017.03.28/xlf/16.1.0/lib/ -L /usr/tcetmp/packages/blas/blas-3.6.0-xlf-15.1.5/lib -L /usr/tcetmp/packages/lapack/lapack-3.6.0-xlf-15.1.5/lib/ -lxlf90 -llapack -lblas  -L $(CUDA_HOME)/lib64 -lcudart -lnvToolsExt -lcuda -L $(RAJA_LOCATION)/lib -lRAJA  -lcudadevrt