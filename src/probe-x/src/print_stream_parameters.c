#include "print_stream_parameters.h"
#include "print_utils.h"
#include "print_disposition_info.h"

// fn declarations
void print_codec_descriptions(StringCache* sc, AVCodecParameters *par);
void print_codec_profile(StringCache* sc, AVCodecParameters *par);
void print_avi_fourcc(StringCache* sc, AVCodecParameters *par);
void print_r_frame_rate(StringCache* sc, AVStream* stream);
void print_avg_frame_rate(StringCache* sc, AVStream* stream);
void print_time_base(StringCache* sc, AVStream* stream);
void print_start_pts(StringCache* sc, AVStream* stream);
void print_start_time(StringCache* sc, AVStream* stream);
void print_duration_ts(StringCache* sc, AVStream* stream);
void print_duration(StringCache* sc, AVStream* stream);
void print_bit_rate(StringCache* sc, AVCodecParameters *par);

void print_nb_frames(StringCache* sc, AVStream* stream);
void print_max_bit_rate(StringCache* sc, AVCodecContext* decoderCtx);
void print_bit_per_raw_sample(StringCache* sc, AVCodecContext* decoderCtx);

void print_stream_parameters(
  StringCache* sc, 
  AVCodecParameters *par, 
  AVStream* stream,
  AVCodecContext* decoderCtx
  ) {

  print_codec_descriptions(sc, par);
  print_codec_profile(sc, par);
  print_avi_fourcc(sc, par);
  print_r_frame_rate(sc, stream);
  print_avg_frame_rate(sc, stream);
  print_start_pts(sc, stream);
  print_start_time(sc, stream);
  print_duration_ts(sc, stream);
  print_duration(sc, stream);
  print_bit_rate(sc, par);
  print_max_bit_rate(sc, decoderCtx);
  print_bit_per_raw_sample(sc, decoderCtx);
  print_nb_frames(sc, stream);
  
  // TODO: sample frames
  //nb_read_frames
  //nb_read_packets

  //show_data
  //extradata_hash
  //dispositions
  print_disposition_info(sc, stream);
  //tags
  //sidedata
}

void print_bit_per_raw_sample(StringCache* sc, AVCodecContext* decoderCtx){
  if (decoderCtx && decoderCtx->bits_per_raw_sample > 0) {
    print_int(sc, "bits_per_raw_sample", decoderCtx->bits_per_raw_sample);
  }
  else {                                             
    print_str(sc, "bits_per_raw_sample", "N/A");
  }
}

void print_max_bit_rate(StringCache* sc, AVCodecContext* decoderCtx) {
  const char unit_bit_per_second_str[] = "bit/s";

  if (decoderCtx && decoderCtx->rc_max_rate > 0) {
    print_value(sc, "max_bit_rate", decoderCtx->rc_max_rate, unit_bit_per_second_str);
  }
  else {
    print_str(sc, "max_bit_rate", "N/A");
  }
}

void print_nb_frames(StringCache* sc, AVStream* stream) {
  if (stream->nb_frames) {
    StringCache_append(sc, "|nb_frames%"PRId64, stream->nb_frames);
  }
  else {
    print_str(sc, "nb_frames", "N/A");
  } 
}

void print_bit_rate(StringCache* sc, AVCodecParameters *par) {
  const char unit_bit_per_second_str[] = "bit/s";

  if (par->bit_rate > 0) {
    print_value(sc, "bit_rate", par->bit_rate, unit_bit_per_second_str);
  }  
  else {
    print_str(sc, "bit_rate", "N/A");
  }
}

void print_r_frame_rate(StringCache* sc, AVStream* stream) {
  print_q(sc, "r_frame_rate", stream->r_frame_rate,   '/');
}

void print_avg_frame_rate(StringCache* sc, AVStream* stream) {
  print_q(sc, "avg_frame_rate", stream->avg_frame_rate, '/');
}

void print_time_base(StringCache* sc, AVStream* stream) {
  print_q(sc, "time_base",      stream->time_base,      '/');
}

void print_start_pts(StringCache* sc, AVStream* stream) {
  print_ts(sc, "start_pts",   stream->start_time, 0);
}

void print_start_time(StringCache* sc, AVStream* stream) {
  print_time(sc, "start_time",  stream->start_time, &stream->time_base, 0);
}

void print_duration_ts(StringCache* sc, AVStream* stream) {
   print_ts(sc, "duration_ts", stream->duration, 0);
}

void print_duration(StringCache* sc, AVStream* stream) {
  print_time(sc, "duration",    stream->duration, &stream->time_base, 0);
}

void print_codec_descriptions(StringCache* sc, AVCodecParameters *par) {
  enum AVCodecID codecId = par->codec_id;
  const AVCodecDescriptor* cd = avcodec_descriptor_get(codecId);

  print_int(sc, "codec_id", codecId);
  if (cd) {
    print_str(sc, "codec_name", cd->name);
    print_str(sc, "codec_long_name", 
      cd->long_name 
        ? cd->long_name
        : "unknown");
  } 
  // else {
  //   print_str_opt("codec_name", "unknown");
  //   print_str_opt("codec_long_name", "unknown"); // !do_bitexact
  // }
}

void print_codec_profile(StringCache* sc, AVCodecParameters *par) {
  char profile_num[12];
  const char *profile = avcodec_profile_name(par->codec_id, par->profile);

  // print_int("profile_num", par->profile);
  if (profile) {
    print_str(sc, "profile", profile);
  }
  else {
    if (par->profile != FF_PROFILE_UNKNOWN) {
      snprintf(profile_num, sizeof(profile_num), "%d", par->profile);
      print_str(sc, "profile", profile_num);
    } 
    // else {
    //   print_str("profile", "unknown");
    // }
  }
}

void print_avi_fourcc(StringCache* sc, AVCodecParameters *par) {
  int32_t tag = par->codec_tag;

  print_str(sc, "codec_tag_string", av_fourcc2str(tag));
  StringCache_append(sc,"|codec_tag=0x%04"PRIx32, tag); 
}