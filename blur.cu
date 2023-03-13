#include "util.h"

#include "cuda.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

using namespace std;

__global__ void blur_kernel(float* d_input, float* d_output, float* d_msk, int width, int height){

}

__global__ void ajustar_brillo_coalesced_kernel(float* d_input, float* d_output, int width, int height, float coef){

}

__global__ void ajustar_brillo_no_coalesced_kernel(float* d_input, float* d_output, int width, int height, float coef){

}

void ajustar_brillo_gpu(float * img_in, int width, int height, float * img_out, float coef, int filas=1){
    
    // Reservar memoria en la GPU

    // copiar imagen y máscara a la GPU
   
    // configurar grilla y lanzar kernel
   
    // transferir resultado a la memoria principal

    // liberar la memoria
}


void blur_gpu(float * img_in, int width, int height, float * img_out, float msk[], int m_size){
    
    // Reservar memoria en la GPU

    // copiar imagen y máscara a la GPU
   
    // configurar grilla y lanzar kernel
   
    // transferir resultado a la memoria principal

	// liberar la memoria
}

void ajustar_brillo_cpu(float * img_in, int width, int height, float * img_out, float coef){

    CLK_POSIX_INIT;
    CLK_POSIX_START;

    for(int imgx=0; imgx < width ; imgx++){
        for(int imgy=0; imgy < height; imgy++){
            img_out[imgy*width+imgx] = min(255.0f,max(0.0f,img_in[imgy*width+imgx]+coef));
        }
    }

    CLK_POSIX_STOP;
    CLK_POSIX_ELAPSED;

    printf("Tiempo ajustar brillo CPU: %f ms\n", t_elap);
}

void blur_cpu(float * img_in, int width, int height, float * img_out, float msk[], int m_size){

    CLK_POSIX_INIT;
    CLK_POSIX_START;

    float val_pixel=0;
    
    //para cada pixel aplicamos el filtro
    for(int imgx=0; imgx < width ; imgx++){
        for(int imgy=0; imgy < height; imgy++){

            val_pixel = 0;

            // aca aplicamos la mascara
            for (int i = 0; i < m_size ; i++){
                for (int j = 0; j < m_size ; j++){
                    
                    int ix =imgx + i - m_size/2;
                    int iy =imgy + j - m_size/2;
                    
                    if(ix >= 0 && ix < width && iy>= 0 && iy < height )
                        val_pixel = val_pixel +  img_in[iy * width +ix] * msk[i*m_size+j];
                }
            }
            
            // guardo valor resultado
            img_out[imgy*width+imgx]= val_pixel;
        }
    }

    CLK_POSIX_STOP;
    CLK_POSIX_ELAPSED;

    printf("Tiempo filtro Gaussiano CPU: %f ms\n", t_elap);
}