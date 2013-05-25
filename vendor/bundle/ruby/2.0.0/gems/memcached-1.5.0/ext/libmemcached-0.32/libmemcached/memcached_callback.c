#include "common.h" 
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/tcp.h>

/* 
  These functions provide data and function callback support
*/

memcached_return memcached_callback_set(memcached_st *ptr, 
                                        memcached_callback flag, 
                                        void *data)
{
  switch (flag)
  {
  case MEMCACHED_CALLBACK_PREFIX_KEY:
    {
      char *key= (char *)data;

      if (key)
      {
        size_t key_length= strlen(key);

        if (memcached_key_test((const char **)&key, &key_length, 1) == MEMCACHED_BAD_KEY_PROVIDED)
        {
          return MEMCACHED_BAD_KEY_PROVIDED;
        }

        if ((key_length > MEMCACHED_PREFIX_KEY_MAX_SIZE -1)
            || (strcpy(ptr->prefix_key, key) == NULL))
        {
          ptr->prefix_key_length= 0;
          return MEMCACHED_BAD_KEY_PROVIDED;
        }
        else
        {
          ptr->prefix_key_length= key_length;
        }
      }
      else
      {
        memset(ptr->prefix_key, 0, MEMCACHED_PREFIX_KEY_MAX_SIZE);
        ptr->prefix_key_length= 0;
      }

      break;
    }
  case MEMCACHED_CALLBACK_USER_DATA:
    {
      ptr->user_data= data;
      break;
    }
  case MEMCACHED_CALLBACK_CLEANUP_FUNCTION:
    {
      memcached_cleanup_func func= *(memcached_cleanup_func *)&data;
      ptr->on_cleanup= func;
      break;
    }
  case MEMCACHED_CALLBACK_CLONE_FUNCTION:
    {
      memcached_clone_func func= *(memcached_clone_func *)&data;
      ptr->on_clone= func;
      break;
    }
#ifdef MEMCACHED_ENABLE_DEPRECATED
  case MEMCACHED_CALLBACK_MALLOC_FUNCTION:
    {
      memcached_malloc_function func= *(memcached_malloc_function *)&data;
      ptr->call_malloc= func;
      break;
    }
  case MEMCACHED_CALLBACK_REALLOC_FUNCTION:
    {
      memcached_realloc_function func= *(memcached_realloc_function *)&data;
      ptr->call_realloc= func;
      break;
    }
  case MEMCACHED_CALLBACK_FREE_FUNCTION:
    {
      memcached_free_function func= *(memcached_free_function *)&data;
      ptr->call_free= func;
      break;
    }
#endif
  case MEMCACHED_CALLBACK_GET_FAILURE:
    {
      memcached_trigger_key func= *(memcached_trigger_key *)&data;
      ptr->get_key_failure= func;
      break;
    }
  case MEMCACHED_CALLBACK_DELETE_TRIGGER:
    {
      memcached_trigger_delete_key func= *(memcached_trigger_delete_key *)&data;
      ptr->delete_trigger= func;
      break;
    }
  default:
    return MEMCACHED_FAILURE;
  }

  return MEMCACHED_SUCCESS;
}

void *memcached_callback_get(memcached_st *ptr, 
                             memcached_callback flag,
                             memcached_return *error)
{
  memcached_return local_error;

  if (!error)
    error = &local_error;

  switch (flag)
  {
  case MEMCACHED_CALLBACK_PREFIX_KEY:
    {
      if (ptr->prefix_key[0] == 0)
      {
        *error= MEMCACHED_FAILURE;
        return NULL;
      }
      else
      {
        *error= MEMCACHED_SUCCESS;
        return (void *)ptr->prefix_key;
      }
    }
  case MEMCACHED_CALLBACK_USER_DATA:
    {
      *error= ptr->user_data ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return (void *)ptr->user_data;
    }
  case MEMCACHED_CALLBACK_CLEANUP_FUNCTION:
    {
      *error= ptr->on_cleanup ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->on_cleanup;
    }
  case MEMCACHED_CALLBACK_CLONE_FUNCTION:
    {
      *error= ptr->on_clone ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->on_clone;
    }
#ifdef MEMCACHED_ENABLE_DEPRECATED
  case MEMCACHED_CALLBACK_MALLOC_FUNCTION:
    {
      *error= ptr->call_malloc ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->call_malloc;
    }
  case MEMCACHED_CALLBACK_REALLOC_FUNCTION:
    {
      *error= ptr->call_realloc ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->call_realloc;
    }
  case MEMCACHED_CALLBACK_FREE_FUNCTION:
    {
      *error= ptr->call_free ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->call_free;
    }
#endif
  case MEMCACHED_CALLBACK_GET_FAILURE:
    {
      *error= ptr->get_key_failure ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->get_key_failure;
    }
  case MEMCACHED_CALLBACK_DELETE_TRIGGER:
    {
      *error= ptr->delete_trigger ? MEMCACHED_SUCCESS : MEMCACHED_FAILURE;
      return *(void **)&ptr->delete_trigger;
    }
  default:
      WATCHPOINT_ASSERT(0);
      *error= MEMCACHED_FAILURE;
      return NULL;
  }
}
