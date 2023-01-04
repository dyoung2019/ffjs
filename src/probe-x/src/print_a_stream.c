#include "print_a_stream.h"
#include "print_video_parameters.h"
#include "print_stream_parameters.h"
#include "print_audio_parameters.h"
#include "print_sub_parameters.h"
#include "print_utils.h"
#include <libavutil/opt.h>
#include "print_tags_dictionary.h"

void print_stream_index(StringCache* sc, int index);
void print_codec_type(StringCache* sc, int codec_type);
void print_context_id(StringCache* sc, AVFormatContext* context, AVStream* stream);
void print_private_data(StringCache* sc, AVCodecContext* decoderCtx);
void print_max_bit_rate(StringCache* sc, AVCodecContext* decoderCtx);
void print_stream_tags(StringCache* sc, AVStream* stream);

void print_a_stream(
  StringCache* sc, 
  AVFormatContext* formatCtx,
  AVStream* stream,
  AVCodecContext* decoderCtx
  ) {

  AVCodecParameters* codecParams = stream->codecpar;

  print_stream_index(sc, stream->index);
  print_codec_type(sc, codecParams->codec_type);
  print_stream_parameters(sc, codecParams, stream, decoderCtx);
  
  switch (codecParams->codec_type) {
    case AVMEDIA_TYPE_VIDEO: 
      print_video_parameters(sc, codecParams, formatCtx, stream, decoderCtx);
      break;
    case AVMEDIA_TYPE_AUDIO: 
      print_audio_parameters(sc, codecParams);
      break;
    case AVMEDIA_TYPE_SUBTITLE:
      print_sub_parameters(sc, codecParams);
      break;
    default: 
      break;
  }

  // write context options 
  print_private_data(sc, decoderCtx);

  print_context_id(sc, formatCtx, stream);

  print_stream_tags(sc, stream);

  // side data
}

void print_stream_tags(StringCache* sc, AVStream* stream) {
  print_tags_dictionary(sc, stream->metadata, "tag");
}

void print_private_data(StringCache* sc, AVCodecContext* decoderCtx) {
  if (decoderCtx && decoderCtx->codec && decoderCtx->codec->priv_class) {
      const AVOption *opt = NULL;
      while ((opt = av_opt_next(decoderCtx->priv_data,opt))) {
          uint8_t *str;
          if (!(opt->flags & AV_OPT_FLAG_EXPORT)) continue;
          if (av_opt_get(decoderCtx->priv_data, opt->name, 0, &str) >= 0) {
              print_u8_data(sc, opt->name, str, 0);
              av_free(str);
          }
      }
  }  
}

void print_stream_index(StringCache* sc, int index) {
  StringCache_append(sc, "stream|index=%d", index);
}

void print_codec_type(StringCache* sc, int codec_type) {
  const char* typeString = NULL;

  switch (codec_type) {
      case AVMEDIA_TYPE_VIDEO: 
        typeString = "video";
        break;
      case AVMEDIA_TYPE_AUDIO: 
        typeString = "audio";
        break;
      case AVMEDIA_TYPE_SUBTITLE: 
        typeString = "subtitle";
        break;                
  }
  
  StringCache_append(sc, "|codec_type=%s", typeString);
}

void print_context_id(StringCache* sc, AVFormatContext* context, AVStream* stream) {
  if (context->iformat->flags & AVFMT_SHOW_IDS) {
    StringCache_append(sc, "|id=0x%x", stream->id);
  }
  else {
    print_str(sc, "id", "N/A");
  }
}