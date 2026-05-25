CLASS z_insert_data_status_prioridad DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_insert_data_status_prioridad IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*  DATA: lt_ztstatus_pp type table of ztstatus_pp.
*
*     lt_ztstatus_pp = value #( ( status_code = 'PE'
*                                 status_description = 'Pending'  )
*                               ( status_code = 'CO'
*                                 status_description = 'Completed'  )
*                                 ).
*
*
*     insert ztstatus_pp from table @lt_ztstatus_pp.
*    if sy-subrc Eq 0.
*    endif.

*      DATA: lt_ztpriority_pp type table of ztpriority_pp.
*
*     lt_ztpriority_pp = value #( ( priority_code = 'A'
*                                 priority_description = 'High'  )
*                               ( priority_code = 'B'
*                                 priority_description = 'Low'  )
*                                 ).
*
*
*     insert ztpriority_pp from table @lt_ztpriority_pp.
*    if sy-subrc Eq 0.
*    endif.
*
*    DATA: lt_ztcustomer2_pp type table of ztcustomer2.
*
*     lt_ztcustomer2_pp = value #( ( customer_id = 10000001
*                                    )
*                               ( customer_id = 10000002
*                                  )
*                                 ).
*
*
*     insert ztcustomer2 from table @lt_ztcustomer2_pp.
*    if sy-subrc Eq 0.
*    endif.



    DATA: lt_zttechnician_pp type table of zttechnician.

     lt_zttechnician_pp = value #( ( technician_id = '10000001'
                                    )
                               ( technician_id = '10000002'
                                  )
                                 ).


     insert zttechnician from table @lt_zttechnician_pp.
    if sy-subrc Eq 0.
    endif.
  ENDMETHOD.

ENDCLASS.
