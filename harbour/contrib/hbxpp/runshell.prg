/*
 * $Id$
 */

/*
 * Harbour Project source code:
 * RUNSHELL()
 *
 * Copyright 2010 Viktor Szakats (harbour.01 syenar.hu)
 * www - http://harbour-project.org
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "common.ch"

FUNCTION RunShell( cCommand, cProgram, lAsync, lBackground )

   /* Not supported (yet?) */
   HB_SYMBOL_UNUSED( lBackground )

   IF ! ISCHARACTER( cProgram )
      #if defined( __PLATFORM__UNIX )
         cProgram := hb_getenv( "SHELL" )
      #elif defined( __PLATFORM__OS2 )
         cProgram := hb_getenv( "OS2_SHELL" )
      #else
         cProgram := hb_getenv( "COMSPEC" )
      #endif
      IF Empty( cProgram )
         #if defined( __PLATFORM__WINDOWS )
            IF hb_osIsWinNT()
               cProgram := "cmd.exe"
            ELSE
               cProgram := "command.com"
            ENDIF
         #elif defined( __PLATFORM__DOS )
            cProgram := "command.com"
         #elif defined( __PLATFORM__OS2 )
            cProgram := "cmd.exe"
         #else
            cProgram := ""
         #endif
      ENDIF
   ENDIF

   IF ISCHARACTER( cCommand )
      cProgram += " " + cCommand
   ENDIF

   RETURN hb_processRun( LTrim( cProgram ), NIL, NIL, NIL, lAsync )