#include <stdio.h>
#include <math.h>
#include <errno.h>
#include <string.h>

#include "bigint.h"

BigInt* construct(int value) {
  BigInt* new_big_int = malloc(sizeof(BigInt));

  if(!new_big_int) {
    return NULL;
  }

  if(!value){
    new_big_int->num_digits = 1;
  }
  else new_big_int->num_digits = floor(log2(value)/32) + 1;

  new_big_int->num_allocated_digits = 32;
}



BigInt* normalize(BigInt *num) {
  if(num != NULL) {
    return num;
  }
  else return NULL;
}

void printBigInt(BigInt *num) {

}
