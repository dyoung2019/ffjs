#include "print_audio_parameters.h"
#include "print_utils.h"
#include <libavcodec/codec_id.h>
#include <libavutil/bprint.h>
#include <libavutil/channel_layout.h>

// fn declarations
void print_sample_format(StringCache* sc, AVCodecParameters* par);
void print_sample_rate(StringCache* sc, AVCodecParameters* par);
void print_channel_layout(StringCache* sc, AVCodecParameters* par);
void print_bit_per_sample(StringCache* sc, AVCodecParameters* par);

void print_audio_parameters(StringCache* sc, AVCodecParameters* par) {
  print_sample_format(sc, par);
  print_sample_rate(sc, par);
  print_channel_layout(sc, par);
}

void print_sample_format(StringCache* sc, AVCodecParameters* par) {
  const char *s = av_get_sample_fmt_name(par->format);
  if (s) {
    print_str(sc, "sample_fmt", s);
  }
  // else {
  //  print_str_opt("sample_fmt", "unknown");
  // }
}

void print_sample_rate(StringCache* sc, AVCodecParameters* par) {
  const char UNIT_HERTZ[]          = "Hz"   ;
  print_value(sc, "sample_rate", par->sample_rate, UNIT_HERTZ);
}

void print_channel_layout(StringCache* sc, AVCodecParameters* par) {
  AVBPrint pbuf;

  av_bprint_init(&pbuf, 1, AV_BPRINT_SIZE_UNLIMITED);
  if (par->ch_layout.order == AV_CHANNEL_ORDER_UNSPEC) {
    av_bprint_clear(&pbuf);
    av_channel_layout_describe_bprint(&par->ch_layout, &pbuf);
    print_str(sc, "channel_layout", pbuf.str);
  } 
  else {
    print_int(sc, "channels", par->ch_layout.nb_channels);
  }
  av_bprint_finalize(&pbuf, NULL);
}

void print_bit_per_sample(StringCache* sc, AVCodecParameters* par) {
  print_int(sc, "bits_per_sample", av_get_bits_per_sample(par->codec_id));
}

