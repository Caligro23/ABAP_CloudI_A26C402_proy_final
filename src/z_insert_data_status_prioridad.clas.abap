CLASS z_insert_data_status_prioridad DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_insert_data_status_prioridad IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lt_ztstatus_pp TYPE TABLE OF ztstatus_pp.

    lt_ztstatus_pp = VALUE #( ( status_code = 'PE'
                                status_description = 'Pending'  )
                              ( status_code = 'CO'
                                status_description = 'Completed'  )
                                ).


    INSERT ztstatus_pp FROM TABLE @lt_ztstatus_pp.
    IF sy-subrc EQ 0.
    ENDIF.

    DATA: lt_ztpriority_pp TYPE TABLE OF ztpriority_pp.

    lt_ztpriority_pp = VALUE #( ( priority_code = 'A'
                                priority_description = 'High'  )
                              ( priority_code = 'B'
                                priority_description = 'Low'  )
                                ).


    INSERT ztpriority_pp FROM TABLE @lt_ztpriority_pp.
    IF sy-subrc EQ 0.
    ENDIF.

    DATA: lt_ztcustomer2_pp TYPE TABLE OF ztcustomer2.

    lt_ztcustomer2_pp = VALUE #( ( customer_id = 10000001
                                   )
                              ( customer_id = 10000002
                                 )
                                ).


    INSERT ztcustomer2 FROM TABLE @lt_ztcustomer2_pp.
    IF sy-subrc EQ 0.
    ENDIF.



    DATA: lt_zttechnician_pp TYPE TABLE OF zttechnician.

    lt_zttechnician_pp = VALUE #( ( technician_id = '10000001'
                                   )
                              ( technician_id = '10000002'
                                 )
                                ).


    INSERT zttechnician FROM TABLE @lt_zttechnician_pp.
    IF sy-subrc EQ 0.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
