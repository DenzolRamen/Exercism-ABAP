CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    " add solution here
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
    " add solution here
    CHECK me->scores_list IS NOT INITIAL.
    result = me->scores_list[ lines( me->scores_list ) ].
  ENDMETHOD.

  METHOD personalbest.
    " add solution here
    DATA: lt_data TYPE integertab.

    CHECK me->scores_list IS NOT INITIAL.
    
    CLEAR: lt_data.
    lt_data = me->scores_list.

    SORT lt_data
      BY table_line DESCENDING.

    result = lt_data[ 1 ].
  ENDMETHOD.

  METHOD personaltopthree.
    " add solution here
    DATA: lt_data  TYPE integertab,
          lv_index TYPE sy-index.

    CHECK me->scores_list IS NOT INITIAL.
    
    CLEAR: lt_data,
           lv_index.
    
    lt_data = me->scores_list.

    DATA(lv_lines) = lines( me->scores_list ).

    IF lv_lines > 3.
      lv_lines = 3.
    ENDIF.

    SORT lt_data
      BY table_line DESCENDING.

    DO lv_lines TIMES.
      lv_index = sy-index.

      APPEND lt_data[ lv_index ] TO result.
    ENDDO. 
  ENDMETHOD.


ENDCLASS.
