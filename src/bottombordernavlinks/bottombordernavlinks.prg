/* Bottom Border Nav Links */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cMenu
   LOCAL lContinue := .T.
   LOCAL nCol
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMaxRow := MaxRow()
   LOCAL nMenuIndex := 0
   LOCAL nRow := 1
   LOCAL nMRow := 1

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "Home", "Search", "Contact", "Login" }

   FOR EACH cMenu IN aMenu
      cMenu :=  "  " + cMenu + "  "
   NEXT

   Scroll()

   hb_DispBox( 3, 0, nMaxRow, nMaxCol, Space( 9 ), "15/15" )
   DO WHILE lContinue

      aMenuPos := {}
      nCol := 0

      DispBegin()
      FOR EACH cMenu IN aMenu
         //hb_DispOutAt( nRow - 1, nCol, Space( Len( cMenu ) ), "00/00" )
         hb_DispOutAt( nRow, nCol, cMenu, "15/00" )
         hb_DispOutAt( nRow + 1, nCol, Replicate( hb_UTF8ToStrBox( "▄" ), Len( cMenu ) ), iif( cMenu:__enumIndex() == nMenuIndex, "14/00", "00/00" ) )
         AAdd( aMenuPos, nCol )
         nCol += Len( cMenu )
      NEXT
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         nMenuIndex := 0

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= aMenuPos[ i ] + Len( aMenu[ i ] ) - 1
               nMenuIndex := i
            ENDIF
         NEXT

         EXIT

      CASE K_LBUTTONDOWN

         FOR i := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= aMenuPos[ i ] + Len( aMenu[ i ] ) - 1
               Alert( aMenu[ i ] )
            ENDIF
         NEXT

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
