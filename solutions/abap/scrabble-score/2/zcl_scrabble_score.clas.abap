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

    "Solution 2
    DATA(lv_input) = TO_UPPER( input ).
    CONDENSE lv_input NO-GAPS.

    result =  COUNT( val = lv_input REGEX = '[AEIOULNRST]' ) * 1  
           +  COUNT( val = lv_input REGEX = '[DG]' ) * 2
           +  COUNT( val = lv_input REGEX = '[BCMP]' ) * 3 
           +  COUNT( val = lv_input REGEX = '[FHVWY]' ) * 4 
           +  COUNT( val = lv_input REGEX = '[K]' ) * 5 
           +  COUNT( val = lv_input REGEX = '[JX]' ) * 8 
           +  COUNT( val = lv_input REGEX = '[QZ]' ) * 10.

  ENDMETHOD.

ENDCLASS.
