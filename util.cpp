
#include "util.h"


//__int64 ctr1 = 0, ctr2 = 0, freq = 0;

void clockStart(cudaEvent_t start){
//	QueryPerformanceCounter((LARGE_INTEGER *)&ctr1);

  cudaEventRecord( start, 0 ); 
}

void clockStop(cudaEvent_t stop){

	/*
	QueryPerformanceCounter((LARGE_INTEGER *)&ctr2);
	QueryPerformanceFrequency((LARGE_INTEGER *)&freq);
	printf("%s --> %fs\n",str,(ctr2 - ctr1) * 1.0 / freq);
	*/

  float tmp_t;

  cudaEventRecord( stop, 0 ); 
  cudaEventSynchronize( stop );
}

float clockElapsed(cudaEvent_t start, cudaEvent_t stop){

	/*
	QueryPerformanceCounter((LARGE_INTEGER *)&ctr2);
	QueryPerformanceFrequency((LARGE_INTEGER *)&freq);
	printf("%s --> %fs\n",str,(ctr2 - ctr1) * 1.0 / freq);
	*/

  float tmp_t;

  cudaEventElapsedTime( &tmp_t, start, stop );

  return tmp_t;
}


void clockInit(cudaEvent_t *start, cudaEvent_t *stop){

  cudaEventCreate(start);
  cudaEventCreate(stop);

}

void print_matrix(const unsigned long long int * M, int width){

	for (int i = 0; i<width; i++){
		for (int j = 0; j<width; j++){
			printf("%Ld ", M[i*width+j]);
		}
		printf("\n");
	}
}

unsigned long long int sum_matrix(const unsigned long long int *M, int width){
	
	unsigned long long int suma = 0;

	for (int i = 0; i<width*width; i++)	suma += M[i];
	
	return suma;
}


void clean_matrix(unsigned long long int *M, int width){

	for (int i = 0; i<width*width; i++) M[i]=0;

}

void clean_float_matrix(float *M, int width, int height){

	for (int i = 0; i<width*height; i++) M[i]=0;

}

void copy_float_matrix(float *M, float *N, int width, int height){

	for (int i = 0; i<width*height; i++) M[i]=N[i];

}

void init_matrix(unsigned long long int *M, int width){
	
	for (int i = 0; i<width*width; i++)	M[i]=rand()%100;
	
}

void  mult_matrix(unsigned long long int *M1,unsigned long long int *M2, int width, unsigned long long int *M3){


clean_matrix(M3,width);

	for (int i=0; i<width;i++)
		for (int j=0; j<width;j++){
			unsigned long long int suma = 0;
			for(int k = 0 ; k < width ; k ++)
				suma += M1[i*width+k] * M2[k*width+j];
			M3[i*width+j] = suma;
		}
}
