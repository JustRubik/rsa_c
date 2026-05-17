#pragma once

#include <stdint.h>

typedef struct {
  uint32_t *digits; //  mảng động uint32, chọn base 32
  size_t size;      //  kích thước tối đa của số
  size_t capacity;  //  Đếu biết, chatGPT gợi ý cái này, vọc sau vậy
} BigInt;

BigInt normalize(BigInt &num);  //  Chuẩn hoá số, xoá chữ số 0 thừa

