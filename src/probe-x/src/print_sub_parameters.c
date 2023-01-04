#include "print_sub_parameters.h"
#include "print_utils.h"

// fn declarations
void print_sub_width(StringCache* sc, AVCodecParameters* par);
void print_sub_height(StringCache* sc, AVCodecParameters* par);

void print_sub_parameters(
  StringCache* sc,
  AVCodecParameters* par) {
  print_sub_width(sc, par);
  print_sub_height(sc, par);
}

void print_sub_width(StringCache* sc, AVCodecParameters* par) {
  if (par->width) {
    print_int(sc, "width", par->width);
  }
}

void print_sub_height(StringCache* sc, AVCodecParameters* par) {
  if (par->width) {
    print_int(sc, "height",  par->height);
  }
}