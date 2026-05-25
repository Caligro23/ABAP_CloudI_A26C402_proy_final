CLASS zcl_work_order_crud_test_pp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS: test_create_work_order,
      test_read_work_order EXPORTING os_work_order    TYPE ztwork_order,
      test_update_work_order,
      test_delete_work_order
      .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_work_order_crud_test_pp IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( |Pruebas de creación de una orden de trabajo| ).
    me->test_create_work_order( ).

    out->write( |Pruebas de visualizar ordenn de trabajo creada| ).
    me->test_read_work_order(
      IMPORTING
        os_work_order = DATA(ls_work_order)
    ).

    out->write( ls_work_order ).

    clear ls_work_order.
    out->write( |Pruebas de actualizar ordenn de trabajo| ).
    me->test_update_work_order( ).

    out->write( |Pruebas de visualizar ordenn de trabajo actualizar| ).
    me->test_read_work_order(
      IMPORTING
        os_work_order = ls_work_order
    ).

    out->write( ls_work_order ).

    clear ls_work_order.
    out->write( |Pruebas de eliminar ordenn de trabajo| ).
    me->test_delete_work_order( ).

    out->write( |Pruebas de visualizar ordenn de trabajo eliminado| ).
    me->test_read_work_order(
      IMPORTING
        os_work_order = ls_work_order
    ).

    IF  ls_work_order-client IS INITIAL.
      out->write( 'No existe el registro' ).
    ELSE.
      out->write( ls_work_order ).
    ENDIF.

  ENDMETHOD.

  METHOD test_create_work_order.

    DATA(go_work_order) = NEW zcl_work_order_crud_handler_pp( ).

    DATA(ls_work_order) = VALUE ztwork_order( work_order_id = 1000000001
                                   customer_id = 10000001
                                   technician_id = '10000001'
                                   creation_date = '20260524'
                                   status        = 'PE'
                                   priority    = 'A'
                                   description = 'Pruebas'
                                                ).

    go_work_order->create_work_order( is_work_order =  ls_work_order ).

  ENDMETHOD.

  METHOD test_delete_work_order.

    DATA(go_work_order) = NEW zcl_work_order_crud_handler_pp( ).

    DATA(ls_work_order_delete) = VALUE ztwork_order( work_order_id = 1000000001
                                              status = 'PE' ).

    go_work_order->delete_work_order( is_work_order =  ls_work_order_delete ).

  ENDMETHOD.

  METHOD test_read_work_order.

    DATA(go_work_order) = NEW zcl_work_order_crud_handler_pp( ).

    go_work_order->read_work_order(
      EXPORTING
        iv_id_work_order = 1000000001
      IMPORTING
        os_work_order    = os_work_order
    ).

  ENDMETHOD.

  METHOD test_update_work_order.

    DATA(go_work_order) = NEW zcl_work_order_crud_handler_pp( ).

    DATA(ls_work_order_update) = VALUE ztwork_order( work_order_id = 1000000001
                                   customer_id = 10000001
                                   technician_id = '10000001'
                                   creation_date = '20260524'
                                   status        = 'CO'
                                   priority    = 'A'
                                   description = 'Pruebas de actualizar'
                                                ).

    go_work_order->update_work_order( is_work_order =  ls_work_order_update ).

  ENDMETHOD.



ENDCLASS.
