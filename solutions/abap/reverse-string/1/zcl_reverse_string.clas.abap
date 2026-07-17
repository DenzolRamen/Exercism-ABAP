CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
    DATA: lv_result TYPE string,
          lv_char   TYPE c LENGTH 1.
    
    CLEAR: lv_result,
           lv_char.

    DATA(lv_len) = strlen( input ).
    DATA(lv_pos) = lv_len - 1.

    DO lv_len TIMES.

      IF lv_pos >= 0.
        lv_char = input+lv_pos(1).
  
        CONCATENATE lv_result lv_char INTO lv_result RESPECTING BLANKS.
        "lv_result = |{ lv_result }{ lv_char }|.
          
        lv_pos = lv_pos - 1.
      ENDIF.
    ENDDO.

    result = lv_result.
    
*    result = input.
  ENDMETHOD.

ENDCLASS.
