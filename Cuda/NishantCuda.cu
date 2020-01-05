#include <stdio.h>
#include <cuda_runtime_api.h>
#include <time.h>
/*
 Compliec
   nvcc -o NishantCuda NishantCuda.cu
*/
__device__ int pwcrack(char *pass){

   char pw1[]="NA1212";
   char pw2[]="CD7895";
   char pw3[]="FG2165";
   char pw4[]="FG7895";

   char *pwd1 = pass;
   char *pwd2 = pass;
   char *pwd3 = pass;
   char *pwd4 = pass;

   char *p1 = pw1;
   char *p2 = pw2;
   char *p3 = pw3;
   char *p4 = pw4;

   while(*pwd1 == *p1){
    
       if(*pwd1 == '\0'){
          return 1;
       }
       pwd1++;
       p1++;
   }
   
    while(*pwd2 == *p2){
    
       if(*pwd2 == '\0'){
          return 1;
       }
       pwd2++;
       p2++;
   }

    while(*pwd3 == *p3){
    
       if(*pwd3 == '\0'){
          return 1;
       }
       pwd3++;
       p3++;
   }

    while(*pwd4 == *p4){
    
       if(*pwd4 == '\0'){
          return 1;
       }
       pwd4++;
       p4++;
   }
 return 0;
}

__global__ void crackfunction() {

 
char alp[26] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
  

char num[10] = {'0','1','2','3','4','5','6','7','8','9'};
  

  char pswd[7];
  pswd[6] = '\0';
  int p, q, r, s;

     for(p=0;p<10;p++){
      for(q=0; q<10; q++){
       for(r=0; r<10; r++){
        for(s=0; s<10; s++){

        pswd[0] = alp[blockIdx.x+65];
        pswd[1] = alp[threadIdx.x+65];
        pswd[2] = num[p];
        pswd[3] = num[q];
        pswd[4] = num[r];
        pswd[5] = num[s];

        if(pwcrack(pswd)){
            printf("Password successfully cracked: %s\n", pswd);
        }

       }
      }
     }
    }
   }

/*
claculating the time difference.
*/
int time_difference(struct timespec *start, struct timespec *finish, long long int *difference)
 {
     long long int ds =  finish->tv_sec - start->tv_sec;
     long long int dn =  finish->tv_nsec - start->tv_nsec;

     if(dn < 0 )
     {
      ds--;
      dn += 1000000000;
      }

     *difference = ds * 1000000000 + dn;
    return !(*difference > 0);
}


/*
  Calulating the time
*/
int main(int argc, char *argv[])
{

    struct timespec start, finish;  
    long long int time_elapsed;

    clock_gettime(CLOCK_MONOTONIC, &start);

    crackfunction <<<26, 26>>>();

    cudaThreadSynchronize();


    clock_gettime(CLOCK_MONOTONIC, &finish);
    time_difference(&start, &finish, &time_elapsed);
     printf("Time elapsed was %lldns or %0.9lfs\n", time_elapsed,(time_elapsed/1.0e9));
  return 0;
}







