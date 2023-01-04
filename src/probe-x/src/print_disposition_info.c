#include "print_disposition_info.h"
#include "print_utils.h"

/* Print disposition information */
#define PRINT_DISP(flagname, name) do {                                \
  StringCache_append(sc, "|disposition:%s=%d", name, !!(stream->disposition & AV_DISPOSITION_##flagname)); \
    } while (0)

void print_disposition_info(StringCache* sc, AVStream* stream) {
  PRINT_DISP(DEFAULT,          "default");
  PRINT_DISP(DUB,              "dub");
  PRINT_DISP(ORIGINAL,         "original");
  PRINT_DISP(COMMENT,          "comment");
  PRINT_DISP(LYRICS,           "lyrics");
  PRINT_DISP(KARAOKE,          "karaoke");
  PRINT_DISP(FORCED,           "forced");
  PRINT_DISP(HEARING_IMPAIRED, "hearing_impaired");
  PRINT_DISP(VISUAL_IMPAIRED,  "visual_impaired");
  PRINT_DISP(CLEAN_EFFECTS,    "clean_effects");
  PRINT_DISP(ATTACHED_PIC,     "attached_pic");
  PRINT_DISP(TIMED_THUMBNAILS, "timed_thumbnails");
  PRINT_DISP(CAPTIONS,         "captions");
  PRINT_DISP(DESCRIPTIONS,     "descriptions");
  PRINT_DISP(METADATA,         "metadata");
  PRINT_DISP(DEPENDENT,        "dependent");
  PRINT_DISP(STILL_IMAGE,      "still_image");
}