#include "print_video_parameters.h"
#include "print_utils.h"
#include <libavutil/pixdesc.h>

// fn declarations 
void print_video_aspect_ratio(
  StringCache* sc,
  AVCodecParameters *par, 
  AVFormatContext *context, 
  AVStream *stream);
void print_pixel_format(StringCache* sc, AVCodecParameters *par);
void print_color_range(StringCache* sc, enum AVColorRange color_range);
void print_color_space(StringCache* sc, enum AVColorSpace color_space);
void print_primaries(StringCache* sc, enum AVColorPrimaries color_primaries);
void print_color_trc(StringCache* sc, enum AVColorTransferCharacteristic color_trc);
void print_chroma_location(StringCache* sc, enum AVChromaLocation chroma_location);
void print_field_order(StringCache* sc, AVCodecParameters *par);

void print_video_width(StringCache* sc, AVCodecParameters *par);
void print_video_height(StringCache* sc, AVCodecParameters *par);
void print_video_delay(StringCache* sc, AVCodecParameters *par);
void print_video_level(StringCache* sc, AVCodecParameters *par);

void print_video_coded_width(StringCache* sc, AVCodecContext* decoderCtx);
void print_video_coded_height(StringCache* sc, AVCodecContext* decoderCtx);
void print_video_closed_captions(StringCache* sc, AVCodecContext* decoderCtx);

void print_video_refs(StringCache* sc, AVCodecContext* decoderCtx);

void print_video_parameters(
  StringCache* sc,
  AVCodecParameters *par, 
  AVFormatContext* formatCtx, 
  AVStream *stream,
  AVCodecContext* decoderCtx) {
    print_video_width(sc, par);
    print_video_height(sc, par);

    print_video_coded_width(sc, decoderCtx);
    print_video_coded_height(sc, decoderCtx);
    print_video_closed_captions(sc, decoderCtx);

    print_video_coded_width(sc, decoderCtx);
    print_video_delay(sc, par);
    print_video_aspect_ratio(sc, par, formatCtx, stream);
    print_pixel_format(sc, par);
    print_video_level(sc, par);

    print_color_range(sc, par->color_range);
    print_color_space(sc, par->color_space);
    print_color_trc(sc, par->color_trc);
    print_primaries(sc, par->color_primaries);
    print_chroma_location(sc, par->chroma_location);
    print_field_order(sc, par);

    print_video_refs(sc, decoderCtx);
}

void print_video_refs(StringCache* sc, AVCodecContext* decoderCtx) {
  if (decoderCtx) {
    print_int(sc, "refs", decoderCtx->refs);
  }
}

void print_video_coded_width(StringCache* sc, AVCodecContext* decoderCtx) {
  if (decoderCtx) {
    print_int(sc, "coded_width", decoderCtx->coded_width);
  }
}

void print_video_coded_height(StringCache* sc, AVCodecContext* decoderCtx) {
  if (decoderCtx) {
    print_int(sc, "coded_height", decoderCtx->coded_height);
  }
}

void print_video_closed_captions(StringCache* sc, AVCodecContext* decoderCtx) {
  if (decoderCtx) {
    print_int(sc, "closed_captions", !!(decoderCtx->properties & FF_CODEC_PROPERTY_CLOSED_CAPTIONS));
  }  
}

void print_video_level(StringCache* sc, AVCodecParameters *par) {
  print_int(sc, "level", par->level);
}

void print_video_delay(StringCache* sc, AVCodecParameters *par) {
  print_int(sc, "has_b_frames", par->video_delay);
}

void print_video_width(StringCache* sc, AVCodecParameters *par) {
  print_int(sc, "width", par->width);
}

void print_video_height(StringCache* sc, AVCodecParameters *par) {
  print_int(sc, "height", par->height);  
}

void print_video_aspect_ratio(
  StringCache* sc,
  AVCodecParameters *par, 
  AVFormatContext *context, 
  AVStream *stream) {
  AVRational sar;
  AVRational dar;

  sar = av_guess_sample_aspect_ratio(context, stream, NULL);
  if (sar.num) {
    print_q(sc, "sample_aspect_ratio", sar, ':');
    av_reduce(&dar.num, &dar.den,
              par->width  * sar.num,
              par->height * sar.den,
              1024*1024);
    print_q(sc, "display_aspect_ratio", dar, ':');
  } 
  // else {
  //   print_str_opt("sample_aspect_ratio", "N/A");
  //   print_str_opt("display_aspect_ratio", "N/A");
  // }
}

void print_pixel_format(StringCache* sc, AVCodecParameters *par) {
    const char *s = av_get_pix_fmt_name(par->format);
    if (s) {
      print_str(sc, "pix_fmt", s);
    }  
    // else {
    //   print_str_opt("pix_fmt", "unknown");
    // }  
}

void print_color_range(StringCache* sc, enum AVColorRange color_range)
{
    const char *val = av_color_range_name(color_range);
    if (val && color_range != AVCOL_RANGE_UNSPECIFIED) {
      print_str(sc, "color_range", val);
    } 
    // else {
    //   print_str_opt("color_range", "unknown");
    // }
}

void print_color_space(StringCache* sc, enum AVColorSpace color_space)
{
    const char *val = av_color_space_name(color_space);
    if (val && color_space != AVCOL_SPC_UNSPECIFIED) {
        print_str(sc, "color_space", val);
    }
    // else {
    //     print_str_opt("color_space", "unknown");
    // }
}

void print_primaries(StringCache* sc, enum AVColorPrimaries color_primaries)
{
    const char *val = av_color_primaries_name(color_primaries);
    if (val && color_primaries != AVCOL_PRI_UNSPECIFIED) {
        print_str(sc, "color_primaries", val);
    } 
    // else {
    //     print_str_opt("color_primaries", "unknown");
    // }
}

void print_color_trc(StringCache* sc, enum AVColorTransferCharacteristic color_trc)
{
    const char *val = av_color_transfer_name(color_trc);
    if (!val && color_trc != AVCOL_TRC_UNSPECIFIED) {
        print_str(sc, "color_transfer", val);
    } 
    // else {
    //     print_str_opt("color_transfer", "unknown");
    // }
}

void print_chroma_location(StringCache* sc, enum AVChromaLocation chroma_location)
{
    const char *val = av_chroma_location_name(chroma_location);
    if (val && chroma_location != AVCHROMA_LOC_UNSPECIFIED) {
        print_str(sc, "chroma_location", val);
    } 
    // else {
    //     print_str_opt("chroma_location", "unspecified");
    // }
}

void print_field_order(StringCache* sc, AVCodecParameters *par) {
  const char* FIELD_NAME = "field_order";

  if (par->field_order == AV_FIELD_PROGRESSIVE) {
    print_str(sc, FIELD_NAME, "progressive");
  }
  else if (par->field_order == AV_FIELD_TT) {
    print_str(sc, FIELD_NAME, "tt");
  }
  else if (par->field_order == AV_FIELD_BB) {
    print_str(sc, FIELD_NAME, "bb");
  }
  else if (par->field_order == AV_FIELD_TB) {
    print_str(sc, FIELD_NAME, "tb");
  }
  else if (par->field_order == AV_FIELD_BT) {
    print_str(sc, FIELD_NAME, "bt");
  }
  // else {
  //   print_str("field_order", "unknown"); // print_str_opt
  // }
}
