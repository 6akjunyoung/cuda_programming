#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void helloCUDA() {
    printf("Hello CUDA from GPU! thread %d\n", threadIdx.x);
}

int main() {
    printf("Hello GPU from CPU!\n");
    helloCUDA<<<1, 10>>>();
    cudaDeviceSynchronize();
    return 0;
}
