CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
* add solution here

    IF input IS NOT INITIAL.
      result = |One for { input }, one for me.|.
    ELSE.
      result = 'One for you, one for me.'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
