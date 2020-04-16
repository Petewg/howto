/* Vertical Menu 02 */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cLine
   LOCAL lContinue := .T.
   LOCAL nCol := 0
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMenuIndex := 0
   LOCAL nRow

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "Home", "Link 1", "Link 2", "Link 3", "Link 4" }

   Scroll()

   DO WHILE lContinue

      aMenuPos := {}
      nRow := 1

      DispBegin()
      FOR EACH cLine IN aMenu
         hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol ), iif( cLine:__enumIsFirst(), "15/02", iif( cLine:__enumIndex() == nMenuIndex, " 08/08", "07/07" ) ) )
         hb_DispOutAt( nRow, nCol, PadL( PadR( cLine, nMaxCol - 2 ), nMaxCol ), iif( cLine:__enumIsFirst(), "15/02", iif( cLine:__enumIndex() == nMenuIndex, "15/08", "00/07" ) ) )
         hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol ), iif( cLine:__enumIsFirst(), "15/02", iif( cLine:__enumIndex() == nMenuIndex, " 08/08", "07/07" ) ) )
         AAdd( aMenuPos, nRow )
         nRow += 3
      NEXT
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         nMenuIndex := 0

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
               nMenuIndex := i
            ENDIF
         NEXT

         EXIT

      CASE K_LBUTTONDOWN

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
               Alert( aMenu[ i ] )
            ENDIF
         NEXT

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
