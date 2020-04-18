/* Off-Canvas Menu */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenuPos
   LOCAL aMenu
   LOCAL cMenu
   LOCAL lButtonClose := .F.
   LOCAL lButtonOpen := .F.
   LOCAL lContinue := .T.
   LOCAL lOpenNav := .F.
   LOCAL nCol := 2
   LOCAL nMaxCol := MaxCol()
   LOCAL nMaxRow := MaxRow()
   LOCAL nRow := 6
   LOCAL nRowSidenav
   LOCAL nMenuIndex := 0

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "About", "Services", "Clients", "Contact" }

   Scroll()

   DO WHILE lContinue

      DispBegin()
      hb_DispBox( 0, 0, nMaxRow, nMaxCol, Space( 9 ), "15/15"  )

      hb_DispOutAt( 1, nCol, "Sidenav Push Example", "00/15" )
      hb_DispOutAt( 3, nCol, "Click on the element below to open the side navigation menu", "00/15" )
      hb_DispOutAt( 4, nCol, "and push this content to the right.", "00/15" )

      hb_DispOutAt( nRow - 1, nCol,  "     ", iif( lButtonOpen, "00/00", "15/15" ) )
      hb_DispOutAt( nRow, nCol,  hb_UTF8ToStrBox( "  ≡  " ), iif( lButtonOpen, "15/00", "00/15" ) )
      hb_DispOutAt( nRow + 1, nCol,  "     ", iif( lButtonOpen, "00/00", "15/15" ) )

      IF lOpenNav

         hb_DispBox( 0, 0, nMaxRow, 13, Space( 9 ), "00/00"  )

         hb_DispOutAt( 1, 11, hb_UTF8ToStrBox( "X" ), iif( lButtonClose, "15/00", "07/00" ) )

         aMenuPos := {}
         nRowSidenav := 4

         FOR EACH cMenu IN aMenu
            hb_DispOutAt( nRowSidenav, 3, cMenu, iif( cMenu:__enumIndex() == nMenuIndex, "15/00", "07/00" ) )
            AAdd( aMenuPos, nRowSidenav )
            nRowSidenav += 3
         NEXT

      ENDIF

      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         IF ! lOpenNav

            lButtonOpen := .F.

            IF MRow() >= nRow - 1 .AND. MRow() <= nRow + 1 .AND. MCol() >= 2 .AND. MCol() <= 6
               lButtonOpen := .T.
            ENDIF

         ELSE

            lButtonClose := .F.

            IF MRow() == 1 .AND. MCol() == 11
               lButtonClose := .T.
            ENDIF

            nMenuIndex := 0

            FOR i := 1 TO Len( aMenu )
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= 12
                  nMenuIndex := i
               ENDIF
            NEXT

         ENDIF

         EXIT

      CASE K_LBUTTONDOWN

         IF ! lOpenNav
            IF MRow() >= nRow - 1 .AND. MRow() <= nRow + 1 .AND. MCol() >= 0 .AND. MCol() <= 5
               lButtonOpen := .F.
               lOpenNav := .T.
               nCol := 16
            ENDIF
         ELSE

            IF MRow() == 1 .AND. MCol() == 11
               lOpenNav := .F.
               nCol := 2
            ENDIF

            FOR i := 1 TO Len( aMenu )
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= 12
                  /* */
               ENDIF
            NEXT
         ENDIF

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
