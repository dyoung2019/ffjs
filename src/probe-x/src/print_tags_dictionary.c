#include "print_tags_dictionary.h"
#include "print_utils.h"
#include "StringCache.h"

void print_tag_pair(StringCache* sc, const char* prefix, char* key, char* value);

void print_tags_dictionary(StringCache* sc, AVDictionary *tags, const char* prefix)
{
    AVDictionaryEntry *tag = NULL;
    // int ret = 0;

    // if (!tags)
    //     return 0;
    // writer_print_section_header(w, section_id);

    while ((tag = av_dict_get(tags, "", tag, AV_DICT_IGNORE_SUFFIX))) {
      print_tag_pair(sc, prefix, tag->key, tag->value);
    }
    // writer_print_section_footer(w);

    // return ret;
}

void print_tag_pair(StringCache* sc, const char* prefix, char* key, char* value) {
  StringCache_append(sc, "|%s:%s=%s", prefix, key, value);
}