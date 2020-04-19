/* Mobile navigation bar horizontal */

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
   LOCAL nButtonIndex := 0
   LOCAL nCol
   LOCAL nMaxCol := MaxCol() + 1
   LOCAL nMaxRow := MaxRow()
   LOCAL nMenuIndex := 0
   LOCAL nRow
   LOCAL nMRow := 1

   LOCAL i

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )

   aButton :=  { hb_UTF8ToStrBox( "  ≡  " ) }
   aMenu := { "  Logo  ", "  News  ", "  Contact  ", "  About  " }
   aText := hb_ATokens( hb_MemoRead( "horizontal.txt" ), .T. )

   Scroll()

   DO WHILE lContinue

      aMenuPos := {}
      nRow := 1
      nCol := 0

      DispBegin()
      Scroll( 0, 9, 2, nMaxCol - 6 )

      FOR EACH cLine IN aMenu

         IF cLine:__enumIsFirst()
            hb_DispOutAt( nRow - 1, nCol, Space( Len( cLine ) ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            hb_DispOutAt( nRow, nCol, cLine, iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            hb_DispOutAt( nRow + 1, nCol, Space( Len( cLine ) ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/02" ) )
            AAdd( aMenuPos, nCol )
         ELSE
            IF lDisplay
               hb_DispOutAt( nRow - 1, nCol, Space( Len( cLine ) ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               hb_DispOutAt( nRow, nCol, cLine, iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               hb_DispOutAt( nRow + 1, nCol, Space( Len( cLine ) ), iif( cLine:__enumIndex() == nMenuIndex, "00/07", "15/00" ) )
               AAdd( aMenuPos, nCol )
            ENDIF
         ENDIF
         nCol += Len( cLine )
      NEXT

      nRow := 3
      nCol := 0
      hb_DispBox( nRow, nCol, nMaxRow, nMaxCol, Space( 9 ), "08/08"  )

      aButtonPos := {}
      nRow := 1

      FOR EACH cLine IN aButton
         hb_DispOutAt( nRow - 1, nMaxCol - 5, Space( 5 ), iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         hb_DispOutAt( nRow, nMaxCol - 5, cLine, iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         hb_DispOutAt( nRow + 1, nMaxCol - 5, Space( 5 ), iif( cLine:__enumIndex() == nButtonIndex, "00/07", "15/00" ) )
         AAdd( aButtonPos, nRow )
      NEXT

      nRow := 3
      FOR EACH cLine IN aText
         hb_DispOutAt( nRow + cLine:__enumIndex(), nCol, PadL( PadR( cLine, nMaxCol ), nMaxCol + 2 ), "15/08" )
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

         IF lDisplay
            FOR i := 1 TO Len( aMenu )
               IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= aMenuPos[ i ] + Len( aMenu[ i ] ) - 1
                  nMenuIndex := i
               ENDIF
            NEXT
         ELSE
            FOR i := 1 TO 1
               IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ i ] .AND. MCol() <= aMenuPos[ i ] + Len( aMenu[ i ] ) - 1
                  nMenuIndex := i
               ENDIF
            NEXT
         ENDIF

         EXIT

      CASE K_LBUTTONDOWN

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
