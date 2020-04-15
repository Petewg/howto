/* Vertical sliding menu */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL nLine
   LOCAL lContinue := .T.
   LOCAL nCol := 0
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMenuIndex := 0
   LOCAL nRow
   LOCAL nNextMenuItem := 0

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aMenu := { "Home", "Link 1", "Link 2", "Link 3", "Link 4", "Link 5", "Link 6", "Link 7", "Link 8", "Link 9" }

   Scroll()

   DO WHILE lContinue

      aMenuPos := {}
      nRow := 1

      DispBegin()
      FOR i := 1 TO 4

         nLine := i + nNextMenuItem

         IF nLine <= Len( aMenu )

            hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol ), iif( nLine == 1, iif( i == nMenuIndex, "00/10", "15/02" ), iif( i == nMenuIndex, " 08/08", "07/07" ) ) )
            hb_DispOutAt( nRow, nCol, PadL( PadR( aMenu[ nLine ], nMaxCol ), nMaxCol + 2 ), iif( nLine == 1, iif( i == nMenuIndex, "00/10", "15/02" ), iif( i == nMenuIndex, "15/08", "00/07" ) ) )
            hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol ), iif( nLine == 1, iif( i == nMenuIndex, "00/10", "15/02" ), iif( i == nMenuIndex, " 08/08", "07/07" ) ) )

            AAdd( aMenuPos, nRow )
            nRow += 3

         ELSE
            EXIT
         ENDIF

      NEXT
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         nMenuIndex := 0

         FOR i := 1 TO  4
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

      CASE K_MWFORWARD

         IF nMenuIndex > 1
            nMenuIndex--
         ELSE
            IF nNextMenuItem >= 1
               nNextMenuItem--
            ENDIF
         ENDIF

         EXIT

      CASE K_MWBACKWARD

         IF nMenuIndex < 4 .AND. nMenuIndex + nNextMenuItem < Len( aMenu )
            nMenuIndex++
         ELSE
            IF nMenuIndex + nNextMenuItem < Len( aMenu )
               nNextMenuItem++
            ENDIF
         ENDIF

         EXIT

      CASE K_UP

         IF nMenuIndex > 1
            nMenuIndex--
         ELSE
            IF nNextMenuItem >= 1
               nNextMenuItem--
            ENDIF
         ENDIF

         EXIT

      CASE K_DOWN

         IF nMenuIndex < 4 .AND. nMenuIndex + nNextMenuItem < Len( aMenu )
            nMenuIndex++
         ELSE
            IF nMenuIndex + nNextMenuItem < Len( aMenu )
               nNextMenuItem++
            ENDIF
         ENDIF

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
