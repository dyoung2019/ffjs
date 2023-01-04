#include "print_utils.h"
#include <libavutil/avstring.h>
#include <libavutil/bprint.h>

// GLOBAL VARIABLES
const struct {
  double bin_val;
  double dec_val;
  const char *bin_str;
  const char *dec_str;
} si_prefixes[] = {
    { 1.0, 1.0, "", "" },
    { 1.024e3, 1e3, "Ki", "K" },
    { 1.048576e6, 1e6, "Mi", "M" },
    { 1.073741824e9, 1e9, "Gi", "G" },
    { 1.099511627776e12, 1e12, "Ti", "T" },
    { 1.125899906842624e15, 1e15, "Pi", "P" },
};

const char unit_second_str[]         = "s";
const char unit_byte_str[]           = "byte" ;


struct unit_value {
    union { double d; long long int i; } val;
    const char *unit;
};

char *value_string(char *buf, int buf_size, struct unit_value uv);

void print_q(StringCache* sc, const char* key, AVRational value, char sep) {
  StringCache_append(sc, "|%s=%d%c%d", key, value.num, sep, value.den);
}

void print_int(StringCache* sc, const char* key, int value) {
  StringCache_append(sc, "|%s=%d", key, value);
}

void print_str(StringCache* sc, const char* key, const char* value) {
  StringCache_append(sc, "|%s=%s", key, value);
}

void print_ts(StringCache *sc, const char *key, int64_t ts, int is_duration)
{
  // printf("\nU64 %s=%"PRIu64 "\n", key, ts);
  // printf("\nS64 %s=%"PRId64"\n", key, ts);
  // printf("\nAV %s s=%"PRId64 ",u=%"PRIu64"\n", key, AV_NOPTS_VALUE, AV_NOPTS_VALUE);

  if ((!is_duration && ts == AV_NOPTS_VALUE) || (is_duration && ts == 0)) {
    StringCache_append(sc, "|%s=%s", key, "N/A");
  } else {
    StringCache_append(sc, "|%s=%lld", key, ts);
  }
}

void print_time(StringCache *sc, const char *key,
  int64_t ts, const AVRational *time_base, int is_duration)
{
  char buf[128];

  if ((!is_duration && ts == AV_NOPTS_VALUE) || (is_duration && ts == 0)) {
      StringCache_append(sc, "|%s=%s", key, "N/A");
  } else {
      double d = ts * av_q2d(*time_base);
      struct unit_value uv;
      uv.val.d = d;
      uv.unit = unit_second_str;
      value_string(buf, sizeof(buf), uv);
      print_str(sc, key, buf);
  }
}

void print_value(StringCache* sc, const char* key, long long int v, const char* u) { 
  char val_str[128];
  struct unit_value uv;                                          
  uv.val.i = v;                                                  
  uv.unit = u;                                                   
  print_str(sc, key, value_string(val_str, sizeof(val_str), uv)); 
}

char *value_string(char *buf, int buf_size, struct unit_value uv)
{
    const int use_value_sexagesimal_format = 0;
    const int use_value_prefix             = 0;
    const int show_value_unit              = 0;
    const int use_byte_value_binary_prefix = 0;

    double vald;
    long long int vali;
    int show_float = 0;

    if (uv.unit == unit_second_str) {
        vald = uv.val.d;
        show_float = 1;
    } else {
        vald = vali = uv.val.i;
    }

    if (uv.unit == unit_second_str && use_value_sexagesimal_format) {
        double secs;
        int hours, mins;
        secs  = vald;
        mins  = (int)secs / 60;
        secs  = secs - mins * 60;
        hours = mins / 60;
        mins %= 60;
        snprintf(buf, buf_size, "%d:%02d:%09.6f", hours, mins, secs);
    } else {
        const char *prefix_string = "";

        if (use_value_prefix && vald > 1) {
            long long int index;

            if (strcmp(uv.unit, unit_byte_str) == 0 && use_byte_value_binary_prefix) {
                index = (long long int) (log2(vald)) / 10;
                index = av_clip(index, 0, FF_ARRAY_ELEMS(si_prefixes) - 1);
                vald /= si_prefixes[index].bin_val;
                prefix_string = si_prefixes[index].bin_str;
            } else {
                index = (long long int) (log10(vald)) / 3;
                index = av_clip(index, 0, FF_ARRAY_ELEMS(si_prefixes) - 1);
                vald /= si_prefixes[index].dec_val;
                prefix_string = si_prefixes[index].dec_str;
            }
            vali = vald;
        }

        if (show_float || (use_value_prefix && vald != (long long int)vald))
            snprintf(buf, buf_size, "%f", vald);
        else
            snprintf(buf, buf_size, "%lld", vali);
        av_strlcatf(buf, buf_size, "%s%s%s", *prefix_string || show_value_unit ? " " : "",
                 prefix_string, show_value_unit ? uv.unit : "");
    }

    return buf;
}

// void load_utf8_string(const char *src) {
//   const uint8_t *p;
//   uint32_t code;
//   for (p = (uint8_t *)src; *p;) {
//     GET_UTF8(code, *p ? *p++ : 0, return -1)
//   }
//   return 0; // 
// }


// int validate_string(StringCache* sc, char **dstp, const char *src)
// {
//   return load_utf8_string(src);
// }

void print_u8_data(StringCache* sc, 
  const char *name,
  uint8_t *data,
  int size) {

  AVBPrint bp;
  int offset = 0, l, i;

  av_bprint_init(&bp, 0, AV_BPRINT_SIZE_UNLIMITED);
  av_bprintf(&bp, "\n");
  while (size) {
      av_bprintf(&bp, "%08x: ", offset);
      l = FFMIN(size, 16);
      for (i = 0; i < l; i++) {
          av_bprintf(&bp, "%02x", data[i]);
          if (i & 1)
              av_bprintf(&bp, " ");
      }
      av_bprint_chars(&bp, ' ', 41 - 2 * i - i / 2);
      for (i = 0; i < l; i++)
          av_bprint_chars(&bp, data[i] - 32U < 95 ? data[i] : '.', 1);
      av_bprintf(&bp, "\n");
      offset += l;
      data   += l;
      size   -= l;
  }
  print_str(sc, name, bp.str);
  av_bprint_finalize(&bp, NULL);

}
