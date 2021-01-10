 //322060187 Gali Seregin

#include "ex1.h"
//func is checking if compiled in big edian or not
int is_big_endian(){
long l=1;
char *Pr=(char*)&l;
if (*Pr){
   return 0;
}
else{
   return 1;
}
}
// func is merging 2 bytes arras
unsigned long merge_bytes(unsigned long x, unsigned long int y){
    char *pointX=(char*)&x;
    char *pointY=(char*)&y;
    char arr[sizeof(unsigned long)];
    if(is_big_endian()==1){
       //if compiled in big endian
     for (int i=0;i<sizeof(unsigned long)/2;i++){
        arr[i]=pointX[i];
     }
     for (int i=sizeof(unsigned long)/2;i<sizeof(unsigned long);i++){
        arr[i]=pointY[i];
     }
    }
     if(is_big_endian()==0){
        //if compiled in little endian
     for (int i=0;i<sizeof(unsigned long)/2;i++){
        arr[i]=pointY[i];
     }
     for (int i=sizeof(unsigned long)/2;i<sizeof(unsigned long);i++){
        arr[i]=pointX[i];
     }
    }
    return (*((unsigned long*)arr));

}
unsigned long put_byte(unsigned long x, unsigned char b, int i){
    char *pointX=(char*)&x;
    char arr[sizeof(long)];
    if(is_big_endian()==1){
     for (int j = 0; j <sizeof(long) ; j++)
     { 
         arr[j]=pointX[j];
       
       if (j ==sizeof(long)-1-i)
       {
          arr[j]=b;
       }
        
      }
   }
   else if(is_big_endian()==0){
     for (int j = sizeof(long)-1; j >=0 ; j--)
     { 
         arr[j]=pointX[j];
       
       if (j ==sizeof(long)-1-i)
       {
          arr[j]=b;
       }
      }
   }
   return *((unsigned long*)arr);
}