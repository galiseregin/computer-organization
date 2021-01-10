// 322060187 Gali Seregin
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int Flages(char* IOFlage){
    int flag= 0;//1=win,2=mac,3=unix
    char str1[] = "-win", str2[] = "-mac", str3[] = "-unix",str4[]= "-swap",str5[]="-keep";
    if(strcmp(IOFlage,str1)==0){
         flag=1;
    }
    else if(strcmp(IOFlage,str2)==0){
         flag=2;
    }
    else if(strcmp(IOFlage,str3)==0){
         flag=3;
    }
    else if(strcmp(IOFlage,str4)==0){
         flag=4;
    }
    else if(strcmp(IOFlage,str5)==0){
         flag=5;
    }
    return flag;
}

void FirstPart(FILE *fc, FILE *fp) {
   
  size_t read;
  char buffer[2];

  read = fread(buffer, sizeof(char), sizeof(buffer), fc);
  while (read) {
    fwrite(buffer, sizeof(char), read, fp);
    read = fread(buffer, sizeof(char), sizeof(buffer), fc);
  }
}

void swap(char buffer[]) {
 char temp;
    temp=buffer[0];
    buffer[0]=buffer[1];
    buffer[1]=temp;
}  

void PartThree(FILE *fc, FILE *fp, char *InputCodeFlag, char *OutPutCodeFlag, char* flag){
  size_t read;
char buffer[2];
int endType;
int flagInput=Flages(InputCodeFlag);
int flagOutput=Flages(OutPutCodeFlag);
int changeFlage=Flages(flag);
  read = fread(buffer, sizeof(char), 2, fc);

  while (read == 2) {
//checking type of endien
    if ((buffer[0]=='\n'&&buffer[1]=='\0')||(buffer[0]=='\r'&&buffer[1]=='\0')||
    (buffer[0]=='\0'&&buffer[1]=='\n')||(buffer[0]=='\0'&&buffer[1]=='\r')){
        if((buffer[0]=='\n'&&buffer[1]=='\0')||(buffer[0]=='\r'&&buffer[1]=='\0')) {
          endType=0;
        }
        else if((buffer[0]=='\0'&&buffer[1]=='\n')||(buffer[0]=='\0'&&buffer[1]=='\r')){
            endType=1;
        }
          //flages: 1=win,2=mac,3=unix
          //need to chack why flages dont work here )=
       if (strcmp(InputCodeFlag, "-win") == 0) {

        read = fread(buffer, sizeof(char), 2, fc);
      }
      //win->unix
      if (strcmp(OutPutCodeFlag, "-unix") == 0) {

        buffer[endType] = '\n';
        buffer[1 - endType] = '\0';

      } 
      //win->mac
      else if (strcmp(OutPutCodeFlag, "-mac") == 0) {

        buffer[endType] = '\r';
        buffer[1 - endType] = '\0';

      } 
      //win->win  \r\n
      else if (strcmp(OutPutCodeFlag, "-win") == 0) {

        buffer[endType] = '\r';
        buffer[1 - endType] = '\0';
      //if swap need for win
        if (strcmp(flag, "-swap") == 0) {
          swap(buffer);
        }
        fwrite(buffer, sizeof(char), read, fp);

        buffer[endType] = '\n';
        buffer[1 - endType] = '\0';
      }
    }
    //swap for unix and mac
    if (strcmp(flag, "-swap") == 0) {
      swap(buffer);
    }

    fwrite(buffer, sizeof(char), read, fp);

    read = fread(buffer, sizeof(char), 2, fc);
      
  }
}

int main(int argc, char *argv[]){
  if ((argv[1] == NULL) || (argv[2] == NULL)) {
    exit(0);
  }
  FILE *fc = fopen(argv[1], "rb");//src file 
  FILE *fp = fopen(argv[2], "wb");//file to paste in
  if (fc == NULL) {
    fclose(fc);
    exit(0);
  }

  if (argv[3]!=NULL && argv[4]!=NULL) {
    char *InputCodeFlage=argv[3];
    char *OutPutCodeFlag=argv[4];
    //Flages: 1=win,2=mac,3=unix
        if(Flages(InputCodeFlage)!=1
        &&Flages(InputCodeFlage)!=2
        &&Flages(InputCodeFlage)!=3
        ||Flages(OutPutCodeFlag)!=1
        &&Flages(OutPutCodeFlag)!=2
        &&Flages(OutPutCodeFlag)!=3){
            fclose(fc);
            fclose(fp);
          exit(0);
        }
  }

    if(argc==3) {
     FirstPart(fc,fp);
    }
    if(argc==5){
        PartThree(fc,fp,argv[3],argv[4],"-keep");
    }
   if(argc==6){
        PartThree(fc,fp,argv[3],argv[4],argv[5]);
    }
  
  fclose(fp);
  fclose(fc);
  return 0;
}


