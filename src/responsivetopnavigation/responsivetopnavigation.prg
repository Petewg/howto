/* Responsive Top Navigation */

#include "inkey.ch"
#include "setcurs.ch"
#include "hbgtinfo.ch"

request hb_gt_wvt_default

#define WHITE_WHITE "w+/w*"
#define WHITE_GRAY  "w+/n*"
#define YELLOW_GRAY "gr+/n*"
#define GREEN_GREEN "g+/g"
#define WHITE_GREEN "w+/g"
#define WHITE_BLACK "w+/n"
#define BLACK_BLACK "n/n"
#define BLACK_WHITE "n/w*"


PROCEDURE Main()

   LOCAL aMenu
   LOCAL aMenuPos
   LOCAL cMenu, nMenuLen, nMenuIndex
   LOCAL lContinue
   LOCAL nRow, nCol, nMRow
   LOCAL nMaxRow, nMaxCol
   LOCAL nI

   Set( _SET_EVENTMASK, hb_bitOr( INKEY_KEYBOARD, HB_INKEY_GTEVENT, INKEY_ALL ) )
   SetCursor( SC_NONE )
	SetBlink( .F. )
	
	nMaxRow := nMaxCol := 0
	nMenuIndex := nMenuLen := 0
	nRow := nMRow := 1
	
   hb_gtInfo( HB_GTI_RESIZEMODE, HB_GTI_RESIZEMODE_ROWS )
	//hb_gtInfo( HB_GTI_SETPOS_ROWCOL, 0, 0 )
   hb_gtInfo( HB_GTI_WINTITLE, "Responsive Top Navigation" )

   aMenu := { "Home", "News", "Contact", "A lengthier than usual prompt!", "About", "Exit!" }

   FOR EACH cMenu IN aMenu
      cMenu := Space( 2 ) + cMenu + Space( 2 )
		nMenuLen += Len( cMenu )
   NEXT

	Setmode( , nMenuLen)
   Scroll()

	lContinue := .T.
	
   DO WHILE lContinue

      IF nMaxRow != MaxRow() .OR. nMaxCol != MaxCol()
         nMaxRow := MaxRow()
         nMaxCol := MaxCol()

         hb_DispBox( nRow+2, 0, nMaxRow, nMaxCol, Space( 9 ), WHITE_WHITE )
			
         hb_DispOutAt( nMaxRow / 2, 0, PadC( "Responsive Top Navigation", nMaxCol ), BLACK_WHITE )

      ENDIF

      aMenuPos := {}
		
      nCol := 0

      DispBegin()
		// let's draw the 1st menu prompt, (usually the `Home`), grayed to be distinct...
		cMenu := aMenu[1]
		hb_DispOutAt( nRow - 1, nCol, Space( Len( cMenu ) ),  WHITE_GRAY  )
      hb_DispOutAt( nRow    , nCol, cMenu                ,  YELLOW_GRAY )
      hb_DispOutAt( nRow + 1, nCol, Space( Len( cMenu ) ),  WHITE_GRAY  )

      FOR EACH cMenu IN aMenu
			hb_DispOutAt( nRow-1, nCol, Space( Len( cMenu ) ), iif( cMenu:__enumIndex() == nMenuIndex, GREEN_GREEN, iif( cMenu:__enumIsFirst(), WHITE_GRAY,  BLACK_BLACK ) ) ) 
			hb_DispOutAt( nRow,   nCol, cMenu                , iif( cMenu:__enumIndex() == nMenuIndex, WHITE_GREEN, iif( cMenu:__enumIsFirst(), YELLOW_GRAY, WHITE_BLACK ) ) )
			hb_DispOutAt( nRow+1, nCol, Space( Len( cMenu ) ), iif( cMenu:__enumIndex() == nMenuIndex, GREEN_GREEN, iif( cMenu:__enumIsFirst(), WHITE_GRAY,  WHITE_BLACK ) ) )
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

         FOR nI := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ nI ] .AND. MCol() <= aMenuPos[ nI ] + Len( aMenu[ nI ] ) - 1
               nMenuIndex := nI
            ENDIF
         NEXT

         EXIT

      CASE K_LBUTTONDOWN

         FOR nI := 1 TO Len( aMenu )
            IF MRow() >= nMRow - 1 .AND. MRow() <= nMRow + 1 .AND. MCol() >= aMenuPos[ nI ] .AND. MCol() <= aMenuPos[ nI ] + Len( aMenu[ nI ] ) - 1
					
					if nI == Len( aMenu ) // last menu element always be exit!
			         lContinue := .F.
					else
					   Alert( aMenu[ nI ] )
					endif
	
            ENDIF
         NEXT
			
			nMenuIndex := 0
         
			EXIT

      ENDSWITCH

   ENDDO

   SetCursor( SC_NORMAL )

   RETURN
