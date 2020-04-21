/* Curtain Menu (no animation) */

#include "hbgtinfo.ch"
#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cMenu
   LOCAL lContinue := .T.
   LOCAL lOpen := .T.
   LOCAL nClose := 0
   LOCAL nMaxCol := 0
   LOCAL nMaxRow := 0
   LOCAL nMenuIndex := 0
   LOCAL nRow

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_ROWS )
   hb_gtInfo( HB_GTI_WINTITLE, "Curtain Menu" )

   aMenu := { "About", "Services", "Clients", "Contact" }

   Scroll()

   DO WHILE lContinue

      IF nMaxRow != MaxRow() .OR. nMaxCol != MaxCol()
         nMaxRow := MaxRow()
         nMaxCol := MaxCol()
      ENDIF

      DispBegin()
      IF lOpen
         hb_DispBox( 0, 0, MaxRow(), MaxCol(), Space( 9 ), "15/15" )
         hb_DispOutAt( 1, 2, hb_UTF8ToStrBox( "≡" ) +  " Open", "00/15" )
         hb_DispOutAt( nMaxRow / 2, 0, PadC( "Responsive Curtain Menu", nMaxCol ), "00/15" )
      ELSE
         aMenuPos := {}
         nRow := Int( ( nMaxRow - 8 ) / 2 )

         hb_DispBox( 0, 0, MaxRow(), MaxCol(), Space( 9 ), "00/00" )

         hb_DispOutAt( 1, nMaxCol - 9, "X Close", iif( 1 == nClose, "15/00", "08/00" ) )

         FOR EACH cMenu IN aMenu

            hb_DispOutAt( nRow, 0, PadC( cMenu, nMaxCol + 1 ), iif( cMenu:__enumIndex() == nMenuIndex, "15/00", "08/00" )  )
            AAdd( aMenuPos, nRow )
            nRow += 3

         NEXT

      ENDIF
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         IF ! lOpen

            nClose := 0
            nMenuIndex := 0

            IF MRow() == 1 .AND. MCol() >= nMaxCol - 9 .AND. MCol() <= nMaxCol - 3
               nClose := 1
               EXIT
            ENDIF

            FOR i := 1 TO 4
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
                  nMenuIndex := i
               ENDIF
            NEXT

         ENDIF

         EXIT

      CASE K_LBUTTONDOWN

         IF lOpen
            IF MRow() == 1 .AND. MCol() >= 2 .AND. MCol() <= 7
               lOpen := .F.
               nClose := 0
            ENDIF
         ELSE

            IF MRow() == 1 .AND. MCol() >= nMaxCol - 9 .AND. MCol() <= nMaxCol - 3
               lOpen := .T.
               EXIT
            ENDIF

            FOR i := 1 TO 4
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
                  Alert( aMenu[ i ] )
               ENDIF
            NEXT
         ENDIF

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
