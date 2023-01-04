#include "print_video_format.h"
#include "print_utils.h"
#include <libavutil/rational.h>
#include <libavutil/avutil.h>
#include "print_tags_dictionary.h"

void print_video_header(StringCache* sc);
void print_video_filename(StringCache* sc, AVFormatContext *context);
void print_nb_streams(StringCache* sc, AVFormatContext *context);
void print_nb_programs(StringCache* sc, AVFormatContext *context);
void print_video_format_name(StringCache* sc, AVFormatContext *context);
void print_video_format_long_name(StringCache* sc, AVFormatContext *context);
void print_video_start_time(StringCache* sc, AVFormatContext *context);
void print_video_duration(StringCache* sc, AVFormatContext *context);
void print_video_size(StringCache* sc, AVFormatContext *context);
void print_video_bit_rate(StringCache* sc, AVFormatContext *context);
void print_video_probe_score(StringCache* sc, AVFormatContext *context);
void print_video_tags(StringCache* sc, AVFormatContext *context);

const AVRational INVERSE_TIMEBASE = AV_TIME_BASE_Q;

void print_video_format(StringCache* sc, AVFormatContext *context) {
  
  print_video_header(sc);
  print_video_filename(sc, context);
  print_nb_streams(sc, context);
  print_nb_programs(sc, context);
  print_video_format_name(sc, context);
  print_video_format_long_name(sc, context);
  print_video_start_time(sc, context);
  print_video_duration(sc, context);
  print_video_size(sc, context);
  print_video_bit_rate(sc, context);
  print_video_probe_score(sc, context);
  print_video_tags(sc, context);
}

void print_video_tags(StringCache* sc, AVFormatContext *context) {
  print_tags_dictionary(sc, context->metadata, "tag");
}

void print_video_header(StringCache* sc) {
  StringCache_append(sc, "format");
}

void print_video_filename(StringCache* sc, AVFormatContext *context) {
  print_str(sc, "filename", context->url);
}

void print_nb_streams(StringCache* sc, AVFormatContext *context) {
  print_int(sc, "nb_streams",  context->nb_streams);
}

void print_nb_programs(StringCache* sc, AVFormatContext *context) {
  print_int(sc, "nb_programs", context->nb_programs);
}

void print_video_format_name(StringCache* sc, AVFormatContext *context) {
  print_str(sc, "format_name", context->iformat->name);
}

void print_video_format_long_name(StringCache* sc, AVFormatContext *context) {
  if (context->iformat->long_name) {
    print_str(sc, "format_long_name", context->iformat->long_name);
  }
  // else {
  //    print_str_opt("format_long_name", "unknown");
  // }                          
}

void print_video_start_time(StringCache* sc, AVFormatContext *context) {
  print_time(sc, "start_time", context->start_time, &INVERSE_TIMEBASE, 0);
}

void print_video_duration(StringCache* sc, AVFormatContext *context) {
  print_time(sc, "duration", context->duration,   &INVERSE_TIMEBASE, 0);
}

void print_video_size(StringCache* sc, AVFormatContext *context) {
  const char unit_byte_str[]  = "byte" ;

  int64_t size = context->pb ? avio_size(context->pb) : -1;
  if (size >= 0) {
    print_value(sc, "size", size, unit_byte_str);
  }
  // else {
  //  print_str_opt("size", "N/A");
  // }
}

void print_video_bit_rate(StringCache* sc, AVFormatContext *context) {
  static const char unit_bit_per_second_str[] = "bit/s";
  if (context->bit_rate > 0) {
    print_value(sc, "bit_rate", context->bit_rate, unit_bit_per_second_str);
  }
  else {
    print_str(sc, "bit_rate", "N/A");
  }
}

void print_video_probe_score(StringCache* sc, AVFormatContext *context) {
  print_int(sc, "probe_score", context->probe_score);
}