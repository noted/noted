/*
 * Summary: Get functions for libmemcached
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Brian Aker
 */

#ifndef __MEMCACHED_GET_H__
#define __MEMCACHED_GET_H__

#ifdef __cplusplus
extern "C" {
#endif

#define GET_LEN_ARG_UNSPECIFIED -1U
#define GET_LEN_BUFSZ 32

/* Public defines */
LIBMEMCACHED_API
char *memcached_get(memcached_st *ptr, 
                    const char *key, size_t key_length,
                    size_t *value_length, 
                    uint32_t *flags,
                    memcached_return *error);

LIBMEMCACHED_API
char *memcached_get_len(memcached_st *ptr, 
                        const char *key, size_t key_length,
                        uint32_t user_spec_len,
                        size_t *value_length, 
                        uint32_t *flags,
                        memcached_return *error);

LIBMEMCACHED_API
memcached_return memcached_mget(memcached_st *ptr, 
                                const char **keys, size_t *key_length, 
                                size_t number_of_keys);

LIBMEMCACHED_API
memcached_return memcached_mget_len(memcached_st *ptr, 
                                    const char **keys, size_t *key_length, 
                                    size_t number_of_keys, uint32_t user_spec_len);

LIBMEMCACHED_API
char *memcached_get_by_key(memcached_st *ptr, 
                           const char *master_key, 
                           size_t master_key_length, 
                           const char *key, size_t key_length,
                           uint32_t user_spec_len,
                           size_t *value_length, 
                           uint32_t *flags,
                           memcached_return *error);

LIBMEMCACHED_API
memcached_return memcached_mget_by_key(memcached_st *ptr, 
                                       const char *master_key, size_t 
                                       master_key_length,
                                       const char **keys, 
                                       size_t *key_length, 
                                       size_t number_of_keys,
                                       uint32_t user_spec_len);

LIBMEMCACHED_API
char *memcached_fetch(memcached_st *ptr, 
                      char *key, size_t *key_length, 
                      size_t *value_length, uint32_t *flags, 
                      memcached_return *error);

LIBMEMCACHED_API
memcached_result_st *memcached_fetch_result(memcached_st *ptr, 
                                            memcached_result_st *result,
                                            memcached_return *error);

LIBMEMCACHED_API
char *memcached_get_from_last(memcached_st *ptr,
                              const char *key,
                              size_t key_length,
                              size_t *value_length, 
                              uint32_t *flags,
                              memcached_return *error);

#ifdef __cplusplus
}
#endif

#endif /* __MEMCACHED_GET_H__ */
