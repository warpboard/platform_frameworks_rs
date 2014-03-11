/*
 * Copyright 2011, The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef FLUSH_CPU_CACHE_H
#define FLUSH_CPU_CACHE_H

#if defined(__arm__) || defined(__aarch64__)

#define FLUSH_CPU_CACHE(BEGIN, END) __clear_cache((BEGIN), (END))

#elif 0 && defined(__mips__)

// Note: Following code does not work with Android Toolchain, though they
// works while using standalone mips-linux-gnu-gcc.

#include <sys/cachectl.h>
#include <unistd.h>

#define FLUSH_CPU_CACHE(BEGIN, END) \
  _flush_cache(reinterpret_cast<char*>(BEGIN), END-BEGIN+1, BCACHE);

#else

#define FLUSH_CPU_CACHE(BEGIN, END) do { } while (0)

#endif

#endif // FLUSH_CPU_CACHE_H
