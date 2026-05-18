#ifndef BIG_INT_H
#define BIG_INT_H

#include <stdint.h>

#ifndef NULL
#define NULL 0
$endif

typedef struct {
  uint32_t *digits;      //  mảng động uint32, chọn base 32
  uint8_t num_digits;   //  2048/32=64 -> dùng 1 byte là quá thừa rồi
                        //  với p và q thì 31-bit
  uint8_t num_allocated_digits; //  31 cho p,q 64 cho n
} BigInt;

BigInt* construct(int value);
BigInt* normalize(BigInt *num);  //  Chuẩn hoá số, xoá chữ số 0 thừa
void printBigInt(BigInt *num);

#endif // BIG_INT_H
