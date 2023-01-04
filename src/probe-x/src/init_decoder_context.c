#include "init_decoder_context.h"
#include "utils.h"

AVCodecContext* init_decoder_context(AVFormatContext *context, AVStream* src) {
  int err = 0;
  AVDictionaryEntry *t = NULL;
  AVCodecContext *dec_ctx = NULL;

  // printf("input stream %d\n", src->index);

  enum AVCodecID codecId = src->codecpar->codec_id;
  if (codecId == AV_CODEC_ID_PROBE) {
    // printf("Failed to probe codec for input stream %d\n", src->index);
    return NULL;
  }

  // printf("avcodec_find_decoder %d BF\n", src->index);
  const AVCodec *codec = avcodec_find_decoder(codecId);
  if (codec == NULL) {
      // printf("Unsupported codec with id %d for input stream %d\n",
      //   codecId,
      //   src->index);
    return NULL;
  }  
  // printf("avcodec_find_decoder %d AF\n", src->index);
      
  
  // printf("filter_codec_opts %d BF\n", src->index); 
  AVDictionary* opts = px_filter_codec_opts(NULL, codecId, context, src, codec);
  // printf("filter_codec_opts %d AF\n", src->index); 

  // printf("avcodec_alloc_context3 %d BF\n", src->index); 
  dec_ctx = avcodec_alloc_context3(codec);
  if (dec_ctx == NULL) {
    // printf("Failed to allocate context %d\n", src->index);
    return NULL;
  }
  // printf("avcodec_alloc_context3 %d AF\n", src->index); 


  // printf("avcodec_parameters_to_context %d BF\n", src->index); 
  err = avcodec_parameters_to_context(dec_ctx, src->codecpar);
  if (err < 0) {
    // printf("Failed to allocate parameters %d\n", src->index);
    return NULL;
  }
  // printf("avcodec_parameters_to_context %d AF\n", src->index); 

  // if (do_show_log) {
  //   // For loging it is needed to disable at least frame threads as otherwise
  //   // the log information would need to be reordered and matches up to contexts and frames
  //   // That is in fact possible but not trivial
  //   av_dict_set(&codec_opts, "threads", "1", 0);
  // }

  // printf("dec_ctx->pkt_timebase %d BF\n", src->index); 
  dec_ctx->pkt_timebase = src->time_base;
  // printf("dec_ctx->pkt_timebase% d AF\n", src->index); 

  // printf("avcodec_open2 %d BF\n", src->index); 
  if (avcodec_open2(dec_ctx, codec, &opts) < 0) {
    // printf("Could not open codec for input stream %d\n", src->index);
    return NULL;
  }
  // printf("avcodec_open2 %d AF\n", src->index); 

  return dec_ctx;
}