CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.

    DATA:
      t_alphas_temp    TYPE alphas,
      t_nums_temp      TYPE nums,
      t_combined_temp  TYPE combined_data,
      wa_combined_temp TYPE combined_data_type,
      lv_tabix         TYPE sy-tabix.

    CLEAR:
      t_alphas_temp,
      t_nums_temp,
      t_combined_temp,
      wa_combined_temp.

    t_alphas_temp = alphas.
    t_nums_temp   = nums.

    LOOP AT t_alphas_temp ASSIGNING FIELD-SYMBOL(<lfs_alphas>).

      CLEAR: lv_tabix.
      lv_tabix = sy-tabix.

      READ TABLE t_nums_temp ASSIGNING FIELD-SYMBOL(<lfs_num>)
        INDEX lv_tabix.
      IF sy-subrc = 0.

        CLEAR: wa_combined_temp.
        wa_combined_temp-colx = <lfs_alphas>-cola && <lfs_num>-col1.
        wa_combined_temp-coly = <lfs_alphas>-colb && <lfs_num>-col2.
        wa_combined_temp-colz = <lfs_alphas>-colc && <lfs_num>-col3.
        APPEND wa_combined_temp TO t_combined_temp.

      ENDIF.
    
    ENDLOOP.
    UNASSIGN <lfs_alphas>.

    combined_data = t_combined_temp.    

  ENDMETHOD.

ENDCLASS.
