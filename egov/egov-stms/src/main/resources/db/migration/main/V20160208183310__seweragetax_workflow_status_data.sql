------ START : Sewerage new application workflow  ---
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'NEW', NULL, NULL, 'Senior Assistant,Junior Assistant', 'NEWSEWERAGECONNECTION', 'Clerk approved', 'Assistant Engineer approval pending', 'Assistant engineer', 'Clerk Approved', 'Forward', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Clerk approved', NULL, NULL, 'Assistant engineer', 'NEWSEWERAGECONNECTION', 'Assistant Engineer approved', 'Estimation Notice generation pending', 'Senior Assistant,Junior Assistant', 'Assistant Engineer approved', 'Submit,Reject', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Assistant Engineer approved', NULL, NULL, 'Senior Assistant,Junior Assistant', 'NEWSEWERAGECONNECTION', 'Estimation Notice generated', 'Donation charges payment pending', 'Senior Assistant,Junior Assistant', 'Payment done against Estimation', 'Generate Estimation Notice', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Estimation Notice generated', NULL, NULL, 'Senior Assistant,Junior Assistant', 'NEWSEWERAGECONNECTION', 'Payment done against Estimation', 'Deputy executive engineer approval pending', 'Deputy executive engineer', 'Payment done against Estimation', 'Submit', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Payment done against Estimation', NULL, NULL, 'Deputy executive engineer', 'NEWSEWERAGECONNECTION', 'Deputy exe engineer approved', 'Executive engineer approval pending', 'Executive engineer', 'Deputy exe engineer approved', 'Forward', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Deputy exe engineer approved', NULL, NULL, 'Executive engineer', 'NEWSEWERAGECONNECTION', 'Executive engineer approved', 'Work order generation pending', 'Senior Assistant,Junior Assistant', 'Executive engineer approved', 'Approve', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Executive engineer approved', NULL, NULL, 'Senior Assistant,Junior Assistant', 'NEWSEWERAGECONNECTION', 'Work order generated', 'Connection execution pending', 'Assistant engineer', 'Work order generated', 'Generate Work Order', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Work order generated', NULL, NULL, 'Assistant engineer', 'NEWSEWERAGECONNECTION', 'END', 'END', NULL, NULL, 'Execute Connection', NULL, NULL, now(), now());
INSERT INTO EG_WF_MATRIX (id, department, objecttype, currentstate, currentstatus, pendingactions, currentdesignation, additionalrule, nextstate, nextaction, nextdesignation, nextstatus, validactions, fromqty, toqty, fromdate, todate) VALUES (nextval('eg_wf_matrix_seq'), 'ANY', 'SewerageApplicationDetails', 'Rejected', NULL, NULL, 'Senior Assistant,Junior Assistant', 'NEWSEWERAGECONNECTION', 'Clerk approved', 'Assistant Engineer approval pending', 'Assistant engineer', NULL, 'Forward,Reject', NULL, NULL, now(), now());
------ END : Sewerage new application workflow  ---


------ START : Sewerage application status ---
Insert into egw_status (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Created',now(),'CREATED',1);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Verified',now(),'VERIFIED',2);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Estimation Notice Generated',now(),'ESTIMATIONNOTICEGENERATED',3);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Estimation Amount Paid',now(),'ESTIMATIONAMOUNTPAID',4);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Work Order Generated',now(),'WORKORDERGENERATED',5);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Checked',now(),'CHECKED',6);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Approved',now(),'APPROVED',7);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Sanctioned',now(),'SANCTIONED',8);
Insert into EGW_STATUS (ID,MODULETYPE,DESCRIPTION,LASTMODIFIEDDATE,CODE,ORDER_ID) values (nextval('SEQ_EGW_STATUS'),'SEWERAGETAXAPPLICATION','Cancelled',now(),'CANCELLED',9);
------ END : Sewerage application status ---

------ START : Application types for workflow ---
INSERT INTO EG_WF_TYPES (id, module, type, link, createdby, createddate, lastmodifiedby, lastmodifieddate, renderyn, groupyn, typefqn, displayname, version) VALUES (nextval('seq_eg_wf_types'), (select id from eg_module where name = 'Sewerage Tax Management'), 'SewerageApplicationDetails', '/stms/transactions/update/:ID', 1, '2015-08-28 10:45:18.201078', 1, '2015-08-28 10:45:18.201078', 'Y', 'N', 'org.egov.stms.transactions.entity.SewerageApplicationDetails', 'Sewerage Connection', 0);
------ END : Application types for workflow ---


--rollback delete from EG_WF_TYPES where type = 'SewerageApplicationDetails' and link = '/stms/transactions/update/:ID';
--rollback delete from egw_status where moduletype = 'SEWERAGETAXAPPLICATION';
--rollback delete from EG_WF_MATRIX where objecttype = 'SewerageApplicationDetails';