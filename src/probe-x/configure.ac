
# based from http://www.idryman.org/blog/2016/03/10/autoconf-tutorial-1/
# Must init the autoconf setup
# The first parameter is project name
# second is version number
# third is bug report address
AC_INIT([probex], [1.0])

AM_EXTRA_RECURSIVE_TARGETS([foo])
# Safety checks in case user overwritten --srcdir
#AC_CONFIG_SRCDIR([hello.c])

# Store the auxiliary build tools (e.g., install-sh, config.sub, config.guess)
# in this dir (build-aux)
AC_CONFIG_AUX_DIR([build-aux])

# Init automake, and specify this program use relaxed structures.
# i.e. this program doesn't follow the gnu coding standards, and doesn't have
# ChangeLog, COPYING, AUTHORS, INSTALL, README etc. files.
AM_INIT_AUTOMAKE([-Wall -Werror])

# Check for C compiler
AC_PROG_CC
AC_PROG_CXX
# We can add more checks in this section

AC_LANG_PUSH([C++])
AC_CHECK_HEADERS([iostream])
AC_CHECK_HEADERS([algorithm])
AC_LANG_POP([C++])

dnl Small macro to print out a nice, pretty section title.
define(SECTION_TITLE,
[
	echo >& AS_MESSAGE_FD
	echo '   $1   ' | sed -e's/./-/g' >&AS_MESSAGE_FD
	echo '   $1' >& AS_MESSAGE_FD
	echo '   $1   ' | sed -e's/./-/g' >&AS_MESSAGE_FD
])


SECTION_TITLE([Checking for ffmpeg])

a=0
AC_CHECK_HEADERS([libavformat/avformat.h libavcodec/avcodec.h libavcodec/codec_id.h libavutil/opt.h libavutil/bprint.h libavutil/dict.h libavutil/avstring.h libavutil/rational.h libavutil/avutil.h libavutil/pixdesc.h libavutil/mem.h], [], [a=1])
AC_SEARCH_LIBS(av_opt_next, avutil, [], [a=1])
AC_SEARCH_LIBS(av_opt_get, avutil, [], [a=1])
AC_SEARCH_LIBS(av_opt_find, avutil, [], [a=1])
AC_SEARCH_LIBS(av_dict_set, avutil, [], [a=1])
AC_SEARCH_LIBS(av_dict_free, avutil, [], [a=1])
AC_SEARCH_LIBS(avformat_alloc_context, avformat, [], [a=1])
AC_SEARCH_LIBS(avformat_close_input, avformat, [], [a=1])
AC_SEARCH_LIBS(avcodec_get_class, avcodec, [], [a=1])
AC_SEARCH_LIBS(avcodec_find_encoder, avcodec, [], [a=1])
AC_SEARCH_LIBS(avcodec_find_decoder, avcodec, [], [a=1])

if test $a == 0
then
	options="$options ffmpeg"
else
	AC_MSG_NOTICE([ffmpeg not found])
fi

# Tells automake to create a Makefile
# See https://www.gnu.org/software/automake/manual/html_node/Requirements.html
AC_CONFIG_FILES([Makefile src/Makefile])

# Generate the output
AC_OUTPUT