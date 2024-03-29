/* this header file comes from libowfat, http://www.fefe.de/libowfat/ */
#ifndef UINT16_H
#define UINT16_H

#include <inttypes.h>	// uint16_t, int16_t
#include <stddef.h>	// size_t

#ifdef __cplusplus
extern "C" {
#endif

typedef uint16_t uint16;
typedef int16_t int16;

#if (defined(__i386__) || defined(__x86_64__)) && !defined(NO_UINT16_MACROS)

static inline void uint16_pack(char* out,uint16 in) {
  *(uint16*)out=in;
}

static inline void uint16_unpack(const char *in,uint16* out) {
  *out=*(const uint16*)in;
}

static inline uint16 uint16_read(const char* in) {
  return *(const uint16*)in;
}

#if defined(__x86_64__) && defined(__GNUC__)

static inline void uint16_pack_big(char* out,uint16 in) {
  *(uint16*)out=__builtin_bswap16(in);
}

static inline void uint16_unpack_big(const char in[2],uint16* out) {
  *out=__builtin_bswap16(*(const uint16*)in);
}

static inline uint16 uint16_read_big(const char in[2]) {
  return __builtin_bswap16(*(const uint16*)in);
}

#else

void uint16_pack_big(char *out,uint16 in);
void uint16_unpack_big(const char *in,uint16* out);
uint16 uint16_read_big(const char *in);

#endif

#else

void uint16_pack(char *out,uint16 in);
void uint16_pack_big(char *out,uint16 in);
void uint16_unpack(const char *in,uint16* out);
void uint16_unpack_big(const char *in,uint16* out);
uint16 uint16_read(const char *in);
uint16 uint16_read_big(const char *in);

#endif

static inline size_t fmt_uint16(char* out, uint16 in) {
  if (out) uint16_pack(out,in);
  return 2;
}

static inline size_t fmt_uint16_big(char* out, uint16 in) {
  if (out) uint16_pack_big(out,in);
  return 2;
}

static inline size_t scan_uint16(const char* in, size_t len, uint16_t* b) {
  if (len<2) return 0;
  *b = uint16_read(in);
  return 2;
}

static inline size_t scan_uint16_big(const char* in, size_t len, uint16_t* b) {
  if (len<2) return 0;
  *b = uint16_read_big(in);
  return 2;
}

#ifdef __cplusplus
}

inline void uint16_pack(unsigned char* out,uint16 in) {
  uint16_pack(reinterpret_cast<char*>(out), in);
}

inline void uint16_pack_big(unsigned char* out,uint16 in) {
  uint16_pack_big(reinterpret_cast<char*>(out), in);
}

inline void uint16_unpack(const unsigned char *in,uint16* out) {
  uint16_unpack(reinterpret_cast<const char*>(in), out);
}

inline void uint16_unpack_big(const unsigned char *in,uint16* out) {
  uint16_unpack_big(reinterpret_cast<const char*>(in), out);
}

inline void uint16_pack(uint16* out,uint16 in) {
  uint16_pack(reinterpret_cast<char*>(out), in);
}

inline void uint16_pack_big(uint16* out,uint16 in) {
  uint16_pack_big(reinterpret_cast<char*>(out), in);
}

inline void uint16_unpack(uint16* *in,uint16* out) {
  uint16_unpack(reinterpret_cast<const char*>(in), out);
}

inline void uint16_unpack_big(uint16* *in,uint16* out) {
  uint16_unpack_big(reinterpret_cast<const char*>(in), out);
}

inline uint16 uint16_read(const unsigned char *in) {
  return uint16_read(reinterpret_cast<const char*>(in));
}

inline uint16 uint16_read_big(const unsigned char *in) {
  return uint16_read_big(reinterpret_cast<const char*>(in));
}

inline uint16 uint16_read(const uint16 *in) {
  return uint16_read(reinterpret_cast<const char*>(in));
}

inline uint16 uint16_read_big(const uint16 *in) {
  return uint16_read_big(reinterpret_cast<const char*>(in));
}

inline uint16 uint_read(const uint16* in) {
  return uint16_read(reinterpret_cast<const char*>(in));
}

inline uint16 uint_read_big(const uint16* in) {
  return uint16_read_big(reinterpret_cast<const char*>(in));
}

#endif


#endif
