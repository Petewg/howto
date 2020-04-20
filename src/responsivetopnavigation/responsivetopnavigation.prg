/* Responsive Top Navigation */

#include "inkey.ch"
#include "setcurs.ch"
#include "hbgtinfo.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cMenu
   LOCAL lContinue := .T.
   LOCAL nCol
   LOCAL nMRow := 1
   LOCAL nMaxCol := 0
   LOCAL nMaxRow := 0
   LOCAL nMenuIndex := 0
   LOCAL nRow := 1

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_ROWS )
   hb_gtInfo( HB_GTI_WINTITLE, "Responsive Top Navigation" )

   aMenu := { "Home", "News", "Contact", "About" }

   FOR EACH cMenu IN aMenu
      cMenu := Space( 2 ) + cMenu + Space( 2 )
   NEXT

   Scroll()

   DO WHILE lContinue

      IF nMaxRow != MaxRow() .OR. nMaxCol != MaxCol()
         nMaxRow := MaxRow()
         nMaxCol := MaxCol()

         hb_DispBox( 3, 0, nMaxRow, nMaxCol, Space( 9 ), "15/15" )
         hb_DispOutAt( nMaxRow / 2, 0, PadC( "Responsive Top Navigation", nMaxCol ), "00/15" )

      ENDIF

      aMenuPos := {}
      nCol := 0

      DispBegin()
      FOR EACH cMenu IN aMenu
         hb_DispOutAt( nRow - 1, nCol, Space( Len( cMenu ) ), iif( cMenu:__enumIsFirst(), "02/02", iif( cMenu:__enumIndex() == nMenuIndex, "07/07", "00/00" ) ) )
         hb_DispOutAt( nRow, nCol, cMenu, iif( cMenu:__enumIsFirst(), "15/02", iif( cMenu:__enumIndex() == nMenuIndex, "00/07", "15/00" ) ) )
         hb_DispOutAt( nRow + 1, nCol, Space( Len( cMenu ) ), iif( cMenu:__enumIsFirst(), "02/02", iif( cMenu:__enumIndex() == nMenuIndex, "07/07", "00/00" ) ) )
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
