%module cmpi

%include "typemaps.i"

%{
#include <stdint.h>

/* OS support macros */
#include <cmpios.h>

/* CMPI convenience macros */
#include <cmpimacs.h>

/* CMPI platform check */
#include <cmpipl.h>


static CMPIData *
clone_data(const CMPIData *dp)
{
  CMPIData *data = (CMPIData *)calloc(1, sizeof(CMPIData));
  memcpy(data, dp, sizeof(CMPIData));
  return data;
}

/*
 * provider code
 */

#if defined(SWIGRUBY)
#include "../src/cmpi_provider_ruby.c"
#endif

#if defined(SWIGPYTHON)
#include "../src/cmpi_provider_python.c"
#endif

%}

# Definitions
%include "cmpi_defs.i"

# Data types
%include "cmpi_types.i"

# Broker callbacks
%include "cmpi_callbacks.i"

