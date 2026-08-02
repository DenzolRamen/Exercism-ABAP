CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.
* add solution here

    TYPES: BEGIN OF ty_color,
             color TYPE string,
             value TYPE i,           
           END OF ty_color,
           tt_color TYPE STANDARD TABLE OF ty_color.

    DATA: lt_color TYPE tt_color,
          lv_color TYPE string.

    CLEAR: lv_color,
           value.
    
    lv_color = color_code.
           
    lt_color = VALUE #(
      ( color = 'black'  value = 0 )
      ( color = 'brown'  value = 1 )
      ( color = 'red'    value = 2 )
      ( color = 'orange' value = 3 )
      ( color = 'yellow' value = 4 )
      ( color = 'green'  value = 5 )
      ( color = 'blue'   value = 6 )
      ( color = 'violet' value = 7 )
      ( color = 'grey'   value = 8 )
      ( color = 'white'  value = 9 )
    ).

    lv_color = to_lower( color_code ).
    
    READ TABLE lt_color ASSIGNING FIELD-SYMBOL(<lfs_color>)
      WITH KEY color = lv_color.
    IF sy-subrc = 0.
      value = <lfs_color>-value.
    ENDIF.  

  ENDMETHOD.

ENDCLASS.
