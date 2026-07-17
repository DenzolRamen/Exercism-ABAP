CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    " add solution here

    DATA: result_temp    TYPE aggregated_data,
          wa_result_temp TYPE aggregated_data_type,
          lv_count       TYPE i,
          lv_sum         TYPE i,
          lv_avg         TYPE f,
          i_temp         TYPE initial_numbers,
          lv_max         TYPE i,
          lv_min         TYPE i.

    CLEAR: result_temp,
           wa_result_temp,
           i_temp,
           lv_max,
           lv_min.

    i_temp = initial_numbers.

    SORT i_temp
      BY group  ASCENDING 
         number ASCENDING.

    LOOP AT i_temp INTO DATA(ls_temp)
      GROUP BY ( group  = ls_temp-group )
      ASSIGNING FIELD-SYMBOL(<lfs_temp>).

      CLEAR: wa_result_temp,
             lv_count,
             lv_sum,
             lv_avg,
             lv_max,
             lv_min.

      lv_max = -999999999.
      lv_min = 999999999.

      wa_result_temp-group = <lfs_temp>-group.

      LOOP AT GROUP <lfs_temp> ASSIGNING FIELD-SYMBOL(<lfs_item>).
        lv_count = lv_count + 1.
        lv_sum = lv_sum + <lfs_item>-number.

*        lv_max = nmax( val1 = lv_max 
*                       val2 = <lfs_item>-number ).
*
*        lv_min = nmin( val1 = lv_min 
*                       val2 = <lfs_item>-number ).

        IF <lfs_item>-number > lv_max.
          lv_max = <lfs_item>-number.
        ENDIF.

        IF <lfs_item>-number < lv_min.
          lv_min = <lfs_item>-number.
        ENDIF.

      ENDLOOP.

      wa_result_temp-count = lv_count.
      wa_result_temp-sum   = lv_sum.
      wa_result_temp-max   = lv_max.
      wa_result_temp-min   = lv_min.

      IF lv_count > 0.  
        lv_avg = lv_sum / lv_count.
      ENDIF.
      wa_result_temp-average = lv_avg.

      APPEND wa_result_temp TO result_temp.
      
    ENDLOOP.

    aggregated_data = result_temp.

  ENDMETHOD.

ENDCLASS.
