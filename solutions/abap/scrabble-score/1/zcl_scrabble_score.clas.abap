CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    " add solution here
    TYPES: ty_char1 TYPE c LENGTH 1.

    DATA: lv_char TYPE c LENGTH 1.
    
    DATA: lr_value1  TYPE RANGE OF ty_char1,
          lr_value2  TYPE RANGE OF ty_char1,
          lr_value3  TYPE RANGE OF ty_char1,
          lr_value4  TYPE RANGE OF ty_char1,
          lr_value5  TYPE RANGE OF ty_char1,
          lr_value8  TYPE RANGE OF ty_char1,
          lr_value10 TYPE RANGE OF ty_char1.

    lr_value1 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'A' )
      ( sign = 'I' option = 'EQ' low = 'E' )
      ( sign = 'I' option = 'EQ' low = 'I' )
      ( sign = 'I' option = 'EQ' low = 'O' )
      ( sign = 'I' option = 'EQ' low = 'U' )
      ( sign = 'I' option = 'EQ' low = 'L' )
      ( sign = 'I' option = 'EQ' low = 'N' )
      ( sign = 'I' option = 'EQ' low = 'R' )
      ( sign = 'I' option = 'EQ' low = 'S' )
      ( sign = 'I' option = 'EQ' low = 'T' )
    ).

    lr_value2 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'D' )
      ( sign = 'I' option = 'EQ' low = 'G' )
    ).

    lr_value3 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'B' )
      ( sign = 'I' option = 'EQ' low = 'C' )
      ( sign = 'I' option = 'EQ' low = 'M' )
      ( sign = 'I' option = 'EQ' low = 'P' )
    ).

    lr_value4 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'F' )
      ( sign = 'I' option = 'EQ' low = 'H' )
      ( sign = 'I' option = 'EQ' low = 'V' )
      ( sign = 'I' option = 'EQ' low = 'W' )
      ( sign = 'I' option = 'EQ' low = 'Y' )
    ).

    lr_value5 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'K' )
    ).

    lr_value8 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'J' )
      ( sign = 'I' option = 'EQ' low = 'X' )
    ).

   lr_value10 = VALUE #(
      ( sign = 'I' option = 'EQ' low = 'Q' )
      ( sign = 'I' option = 'EQ' low = 'Z' )
    ).

   DATA(lv_len) = strlen( input ).

   DO lv_len TIMES.

     DATA(lv_offset) = sy-index - 1.

     lv_char = input+lv_offset(1).
     lv_char = TO_UPPER( lv_char ).

     IF lv_char IN lr_value1.
       result = result + 1.

     ELSEIF lv_char IN lr_value2.
       result = result + 2.

     ELSEIF lv_char IN lr_value3.
       result = result + 3.
      
     ELSEIF lv_char IN lr_value4.
       result = result + 4.

     ELSEIF lv_char IN lr_value5.
       result = result + 5.

     ELSEIF lv_char IN lr_value8.
       result = result + 8.

     ELSEIF lv_char IN lr_value10.
       result = result + 10.
     ENDIF.
  
   ENDDO.
  ENDMETHOD.

ENDCLASS.
