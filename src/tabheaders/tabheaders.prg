/* Tab Headers */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aContent
   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cMenu
   LOCAL lContinue := .T.
   LOCAL nCol
   LOCAL nCount
   LOCAL nMRow := MaxRow() / 2
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMenuIndex := 0
   LOCAL nMenuID := 1
   LOCAL nRow := MaxRow() / 2
   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "London", "Paris", "Tokyo", "Warsaw", "Budapest" }
   aContent := { ;
      "London is the capital city of England.", ;
      "Paris is the capital of France.", ;
      "Tokyo is the capital of Japan.", ;
      "Warsaw is the capital of Poland.", ;
      "Budapest is the capital of Hungary" }

   nCount := Int( nMaxCol / Len( aMenu ) )

   Scroll()

   DO WHILE lContinue

      aMenuPos := {}
      nCol := 0

      DispBegin()
      hb_DispBox( 0, 0, 11, nMaxCol, Space( 9 ), "0" + hb_ntos( nMenuID ) + "/" + "0" + hb_ntos( nMenuID ) )
      hb_DispOutAt( 5, nCol, PadC( aMenu[ nMenuID ], nMaxCol ), "15/0" + hb_ntos( nMenuID )  )
      hb_DispOutAt( 7, nCol, PadC( aContent[ nMenuID ], nMaxCol ), "15/0" + hb_ntos( nMenuID )  )

      FOR EACH cMenu IN aMenu
         hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol ), iif( cMenu:__enumIndex() == nMenuID, "0" + hb_ntos( nMenuID ) + "/" + "0" + hb_ntos( nMenuID ), iif( cMenu:__enumIndex() == nMenuIndex, "07/07", "15/08" ) )  )
         hb_DispOutAt( nRow, nCol, PadC( cMenu, nCount ), iif( cMenu:__enumIndex() == nMenuID, "15/0" + hb_ntos( nMenuID ), iif( cMenu:__enumIndex() == nMenuIndex, "00/07", "15/08" ) ) )
         hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol ), iif( cMenu:__enumIndex() == nMenuID, "0" + hb_ntos( nMenuID ) + "/" + "0" + hb_ntos( nMenuID ), iif( cMenu:__enumIndex() == nMenuIndex,  "07/07", "15/08" ) ) )

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
               nMenuID := i
               EXIT
            ENDIF
         NEXT

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
