/* Navigation Bar Vertical */

#include "inkey.ch"
#include "setcurs.ch"

PROCEDURE Main()

   LOCAL aButton
   LOCAL aButtonPos
   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL aText
   LOCAL cLine
   LOCAL lContinue := .T.
   LOCAL lDisplay := .F.
   LOCAL nCol := 0
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMaxRow := MaxRow()
   LOCAL nButtonIndex := 0
   LOCAL nMenuIndex := 0
   LOCAL nRow

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aButton :=  { hb_UTF8ToStrBox( "  ≡  " ) }
   aMenu := { "Logo", "News", "Contact", "About" }
   aText := hb_ATokens( hb_MemoRead( "vertical.txt" ), .T. )

   Scroll()

   DO WHILE lContinue

      aMenuPos := {}
      nRow := 1

      DispBegin()
      FOR EACH cLine IN aMenu
         IF cLine:__enumIsFirst()
            hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol - 5 ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            hb_DispOutAt( nRow, nCol, PadL( PadR( cLine, nMaxCol ), nMaxCol + 2 ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol - 5 ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            AAdd( aMenuPos, nRow )
         ELSE
            IF lDisplay
               nRow += 3
               hb_DispOutAt( nRow - 1, nCol, Space( nMaxCol ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               hb_DispOutAt( nRow, nCol, PadL( PadR( cLine, nMaxCol ), nMaxCol + 2 ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               hb_DispOutAt( nRow + 1, nCol, Space( nMaxCol ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               AAdd( aMenuPos, nRow )
            ELSE
               EXIT
            ENDIF
         ENDIF
      NEXT

      aButtonPos := {}
      nRow := 1

      FOR EACH cLine IN aButton
         hb_DispOutAt( nRow - 1, nMaxCol - 5, Space( 5 ), iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         hb_DispOutAt( nRow, nMaxCol - 5, cLine, iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         hb_DispOutAt( nRow + 1, nMaxCol - 5, Space( 5 ), iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         AAdd( aButtonPos, nRow )
      NEXT

      nRow := 3
      hb_DispBox( iif( lDisplay, nRow + 9, nRow ), nCol, nMaxRow, nMaxCol, Space( 9 ), "08/08"  )

      nRow := 3
      FOR EACH cLine IN aText
         hb_DispOutAt( iif( lDisplay, nRow + cLine:__enumIndex() + 9, nRow + cLine:__enumIndex() ), nCol, PadL( PadR( cLine, nMaxCol ), nMaxCol + 2 ), "15/08" )
      NEXT
      DispEnd()

      SWITCH Inkey( 0 )
      CASE K_ESC

         lContinue := .F.

         EXIT

      CASE K_MOUSEMOVE

         nButtonIndex := 0
         nMenuIndex := 0

         FOR i := 1 TO 1
            IF MRow() >= aButtonPos[ i ] - 1 .AND. MRow() <= aButtonPos[ i ] + 1 .AND. MCol() >= nMaxCol - 5 .AND. MCol() <= nMaxCol - 1
               nButtonIndex := i

            ENDIF
         NEXT

         IF nButtonIndex == 1
            EXIT
         ENDIF

         IF lDisplay
            FOR i := 1 TO Len( aMenu )
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
                  nMenuIndex := i
               ENDIF
            NEXT
         ELSE
            FOR i := 1 TO 1
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol - 6
                  nMenuIndex := i
               ENDIF
            NEXT
         ENDIF

         EXIT

      CASE K_LBUTTONDOWN

         IF lDisplay
            FOR i := 1 TO Len( aMenu )
               IF i == 1
                  IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol - 6
                     Alert( aMenu[ i ] )
                  ENDIF
               ELSE
                  IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol
                     Alert( aMenu[ i ] )
                  ENDIF
               ENDIF
            NEXT
         ELSE
            FOR i := 1 TO 1
               IF MRow() >= aMenuPos[ i ] - 1 .AND. MRow() <= aMenuPos[ i ] + 1 .AND. MCol() >= 0 .AND. MCol() <= nMaxCol - 6
                  Alert( aMenu[ i ] )
               ENDIF
            NEXT
         ENDIF

         /* */
         FOR i := 1 TO 1
            IF MRow() >= aButtonPos[ i ] - 1 .AND. MRow() <= aButtonPos[ i ] + 1 .AND. MCol() >= nMaxCol - 5 .AND. MCol() <= nMaxCol - 1
               IF lDisplay
                  lDisplay := .F.
               ELSE
                  lDisplay := .T.
               ENDIF
            ENDIF
         NEXT

         EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
