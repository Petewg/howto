/* Equal Width Navbar */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cLine
   LOCAL lContinue := .T.
   LOCAL nCol
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMaxRow := MaxRow()
   LOCAL nMenuIndex := 0
   LOCAL nRow := 1
   LOCAL nCount
   LOCAL nMRow := 1

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "Home", "Search", "Contact", "Login" }
   nCount := Int( nMaxCol / Len( aMenu ) ) 

   Scroll()

   hb_DispBox( 3, 0, nMaxRow, nMaxCol, Space( 9 ), "15/15" )
   DO WHILE lContinue

      aMenuPos := {}
      nCol := 0

      DispBegin()
      FOR EACH cLine IN aMenu
         hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol ), iif( cLine:__enumIsFirst(), "02/02", iif( cLine:__enumIndex() == nMenuIndex, "00/00", "15/08" ) ) )
         hb_DispOutAt( nRow, nCol, PadC( cLine, nCount ), iif( cLine:__enumIsFirst(), "15/02", iif( cLine:__enumIndex() == nMenuIndex, "15/00", "15/08" ) ) )
         hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol ), iif( cLine:__enumIsFirst(), "02/02", iif( cLine:__enumIndex() == nMenuIndex, "00/00", "15/08" ) ) )
         AAdd( aMenuPos, nCol )
         nCol += nCount
      NEXT
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         nMenuIndex := 0

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= nCount * i
               nMenuIndex := i
            ENDIF
         NEXT

         EXIT

      CASE K_LBUTTONDOWN

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= nCount * i
               Alert( aMenu[ i ] )
               EXIT
            ENDIF
         NEXT

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
