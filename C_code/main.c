#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
static  char START[1000];
static char SEARCHABLE[1000];
extern char* Find(char* start, char * searchable);

void randomDate(){
    srand(time(NULL));
    int rand_count = rand() %1000;
    for (int i = 0; i < rand_count; ++i) {
        START[i] = (char)(rand()%128);
    }
    for (int i = 0; i < rand_count; ++i) {
        SEARCHABLE[i] = (char)(rand()%128);
    }
};

int main(int args, char** argv) {
    FILE *in, *out;
    char check[100];
    if(strcmp(argv[1], "-c") == 0){
        args-=2;
        if(args!=2){
            printf("incorrect input");
            return 0;
        }
        char* istr= Find(argv[2],argv[3]);
        if ( istr == NULL)
            printf ("string not found\n");
        else{
            printf ("The search string starts with the character %ld\n", istr - (const char *) argv[2] + 1);
        }
    } else if(strcmp(argv[1], "-f") == 0){
        in = fopen(argv[2],"r");
        out = fopen(argv[3],"w");
        if(fscanf(in, "%s", START) != 1){
            fprintf (out,"%s","incorrect input");
            return 0;
        };
        if(fscanf(in, "%s", SEARCHABLE) != 1){
            fprintf (out,"%s","incorrect input");
            return 0;
        }
        if(fscanf(in,"%s",check)==1){
            fprintf (out,"%s","incorrect input");
            return 0;
        }
        char* istr=Find(START, SEARCHABLE);
        if ( istr == NULL){
            fprintf (out,"%s","not found");
        }
        else{
            fprintf (out,"%s%ld\n","The search string starts with the character ", istr - (const char *) START + 1);
        }
    } else if(strcmp(argv[1], "-r")==0){
        randomDate();
        char* istr= Find(START,SEARCHABLE);
        printf("%s\n",START);
        printf("%s\n",SEARCHABLE);
        if ( istr == NULL)
            printf ("string not found\n");
        else
            printf ("The search string starts with the character %ld\n", istr - (const char *) START + 1);
    }
    else{
        printf("incorrect input");
    }
    return 0;
}
