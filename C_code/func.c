#include <string.h>
#include <time.h>
#include <stdio.h>
void diff(struct timespec st,struct timespec end){
    long long tot1 = st.tv_sec *10e8 +st.tv_nsec;
    long long tot2 = end.tv_sec *10e8 +end.tv_nsec;
    printf("%lld %s\n", tot1-tot2,"ms");
}
char* Find(char* start, char * searchable) {
    struct timespec st;
    struct timespec end;
    clock_gettime(CLOCK_MONOTONIC, &st);
    char* istr = strstr((const char *) start, (const char *) searchable);
    clock_gettime(CLOCK_MONOTONIC, &end);
    diff(end,st);
    return istr;
}