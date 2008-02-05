/* GNU m4 -- A simple macro processor

   Copyright (C) 1989, 1990, 1991, 1992, 1993, 2004, 2006, 2007, 2008
   Free Software Foundation, Inc.

   This file is part of GNU M4.

   GNU M4 is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   GNU M4 is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/* Handling of path search of included files via the builtins "include"
   and "sinclude".  */

#include "m4.h"

struct includes
{
  struct includes *next;	/* next directory to search */
  const char *dir;		/* directory */
  int len;
};

typedef struct includes includes;

static includes *dir_list;		/* the list of path directories */
static includes *dir_list_end;		/* the end of same */
static int dir_max_length;		/* length of longest directory name */


void
include_init (void)
{
  dir_list = NULL;
  dir_list_end = NULL;
  dir_max_length = 0;
}

void
include_env_init (void)
{
  char *path;
  char *path_end;
  char *env_path;

  if (no_gnu_extensions)
    return;

  env_path = getenv ("M4PATH");
  if (env_path == NULL)
    return;

  env_path = xstrdup (env_path);
  path = env_path;

  do
    {
      path_end = strchr (path, ':');
      if (path_end)
	*path_end = '\0';
      add_include_directory (path);
      path = path_end + 1;
    }
  while (path_end);
  free (env_path);
}

void
add_include_directory (const char *dir)
{
  includes *incl;

  if (no_gnu_extensions)
    return;

  if (*dir == '\0')
    dir = ".";

  incl = (includes *) xmalloc (sizeof (struct includes));
  incl->next = NULL;
  incl->len = strlen (dir);
  incl->dir = xstrdup (dir);

  if (incl->len > dir_max_length) /* remember len of longest directory */
    dir_max_length = incl->len;

  if (dir_list_end == NULL)
    dir_list = incl;
  else
    dir_list_end->next = incl;
  dir_list_end = incl;

#ifdef DEBUG_INCL
  xfprintf (stderr, "add_include_directory (%s);\n", dir);
#endif
}

/* Search for FILE, first in `.', then according to -I options.  If
   successful, return the open file, and if RESULT is not NULL, set
   *RESULT to a malloc'd string that represents the file found with
   respect to the current working directory.  */

FILE *
m4_path_search (const char *file, char **result)
{
  FILE *fp;
  includes *incl;
  char *name;			/* buffer for constructed name */
  int e;

  if (result)
    *result = NULL;

  /* Reject empty file.  */
  if (!*file)
    {
      errno = ENOENT;
      return NULL;
    }

  /* Look in current working directory first.  */
  fp = fopen (file, "r");
  if (fp != NULL)
    {
      if (set_cloexec_flag (fileno (fp), true) != 0)
	m4_warn (errno, NULL, _("cannot protect input file across forks"));
      if (result)
	*result = xstrdup (file);
      return fp;
    }

  /* If file not found, and filename absolute, fail.  */
  if (*file == '/' || no_gnu_extensions)
    return NULL;
  e = errno;

  name = (char *) xmalloc (dir_max_length + 1 + strlen (file) + 1);

  for (incl = dir_list; incl != NULL; incl = incl->next)
    {
      strncpy (name, incl->dir, incl->len);
      name[incl->len] = '/';
      strcpy (name + incl->len + 1, file);

#ifdef DEBUG_INCL
      xfprintf (stderr, "m4_path_search (%s) -- trying %s\n", file, name);
#endif

      fp = fopen (name, "r");
      if (fp != NULL)
	{
	  if (debug_level & DEBUG_TRACE_PATH)
	    debug_message ("path search for %s found %s",
			   quotearg_style (locale_quoting_style, file),
			   quotearg_n_style (1, locale_quoting_style, name));
	  if (set_cloexec_flag (fileno (fp), true) != 0)
	    m4_warn (errno, NULL, _("cannot protect input file across forks"));
	  if (result)
	    *result = name;
	  else
	    free (name);
	  errno = e;
	  return fp;
	}
    }
  free (name);
  errno = e;
  return fp;
}

#ifdef DEBUG_INCL

static void M4_GNUC_UNUSED
include_dump (void)
{
  includes *incl;

  xfprintf (stderr, "include_dump:\n");
  for (incl = dir_list; incl != NULL; incl = incl->next)
    xfprintf (stderr, "\t%s\n", incl->dir);
}

#endif /* DEBUG_INCL */
