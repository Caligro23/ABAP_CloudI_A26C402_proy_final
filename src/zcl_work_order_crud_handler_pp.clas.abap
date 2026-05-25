CLASS zcl_work_order_crud_handler_pp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: create_work_order IMPORTING is_work_order TYPE ztwork_order,
      read_work_order IMPORTING iv_id_work_order TYPE ztwork_order-work_order_id
                      EXPORTING os_work_order    TYPE ztwork_order,
      update_work_order IMPORTING is_work_order TYPE ztwork_order,
      delete_work_order IMPORTING is_work_order TYPE ztwork_order.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_work_order_crud_handler_pp IMPLEMENTATION.

  METHOD create_work_order.

*    AUTHORITY-CHECK OBJECT 'ZAOWORKORD'
*    ID 'ZAF_CODEPP' FIELD 'VALIDA'
*    ID 'ACTVT'      FIELD '01'.
*
*    DATA(lv_create_granded) = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*
*    IF lv_create_granded EQ abap_true.

      DATA(lo_valida) = NEW zcl_work_order_validator_pp( ).

      DATA(lv_valida) = lo_valida->validate_create_order(
                          iv_customer_id   = is_work_order-customer_id
                          iv_technician_id = is_work_order-technician_id
                          iv_priority      = is_work_order-priority
                        ).
      IF  lv_valida EQ abap_true.
        INSERT INTO ztwork_order VALUES @is_work_order.
        IF sy-subrc EQ 0.
          COMMIT WORK AND WAIT.
        ENDIF.
      ENDIF.
*    ENDIF.
  ENDMETHOD.

  METHOD delete_work_order.

*    AUTHORITY-CHECK OBJECT 'ZAOWORKORD'
*   ID 'ZAF_CODEPP' FIELD 'VALIDA'
*   ID 'ACTVT'      FIELD '06'.
*
*    DATA(lv_create_granded) = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*
*    IF lv_create_granded EQ abap_true.

      DATA(lo_valida) = NEW zcl_work_order_validator_pp( ).

      DATA(lv_valida) = lo_valida->validate_delete_order(
                          iv_work_order_id = is_work_order-work_order_id
                          iv_status        = is_work_order-status
                        ).
      IF  lv_valida EQ abap_true.
        DELETE FROM ztwork_order WHERE work_order_id =  @is_work_order-work_order_id.
        IF sy-subrc EQ 0.
          COMMIT WORK AND WAIT.
        ENDIF.
      ENDIF.
*    ENDIF.
  ENDMETHOD.

  METHOD read_work_order.
*    AUTHORITY-CHECK OBJECT 'ZAOWORKORD'
*   ID 'ZAF_CODEPP' FIELD 'VALIDA'
*   ID 'ACTVT'      FIELD '03'.
*
*    DATA(lv_create_granded) = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*
*    IF lv_create_granded EQ abap_true.
      SELECT SINGLE FROM ztwork_order
      FIELDS *
      WHERE work_order_id EQ @iv_id_work_order
      INTO @os_work_order.
*    ENDIF.

  ENDMETHOD.

  METHOD update_work_order.
*    AUTHORITY-CHECK OBJECT 'ZAOWORKORD'
*       ID 'ZAF_CODEPP' FIELD 'VALIDA'
*       ID 'ACTVT'      FIELD '02'.
*
*    DATA(lv_create_granded) = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*
*    IF lv_create_granded EQ abap_true.

      DATA(lo_valida) = NEW zcl_work_order_validator_pp( ).

      DATA(lv_valida) = lo_valida->validate_update_order(
                          iv_work_order_id = is_work_order-work_order_id
                          iv_status        = is_work_order-status
                        ).
      IF  lv_valida EQ abap_true.
        UPDATE ztwork_order FROM @is_work_order.
        IF sy-subrc EQ 0.
          COMMIT WORK AND WAIT.
        ENDIF.
      ENDIF.
*    ENDIF.
  ENDMETHOD.

ENDCLASS.
