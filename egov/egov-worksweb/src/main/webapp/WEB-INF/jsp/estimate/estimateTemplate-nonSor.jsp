<%--
  ~ eGov suite of products aim to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) <2015>  eGovernments Foundation
  ~
  ~     The updated version of eGov suite of products as by eGovernments Foundation
  ~     is available at http://www.egovernments.org
  ~
  ~     This program is free software: you can redistribute it and/or modify
  ~     it under the terms of the GNU General Public License as published by
  ~     the Free Software Foundation, either version 3 of the License, or
  ~     any later version.
  ~
  ~     This program is distributed in the hope that it will be useful,
  ~     but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~     GNU General Public License for more details.
  ~
  ~     You should have received a copy of the GNU General Public License
  ~     along with this program. If not, see http://www.gnu.org/licenses/ or
  ~     http://www.gnu.org/licenses/gpl.html .
  ~
  ~     In addition to the terms of the GPL license to be adhered to in using this
  ~     program, the following additional terms are to be complied with:
  ~
  ~         1) All versions of this program, verbatim or modified must carry this
  ~            Legal Notice.
  ~
  ~         2) Any misrepresentation of the origin of the material is prohibited. It
  ~            is required that all modified versions of this material be marked in
  ~            reasonable ways as different from the original version.
  ~
  ~         3) This license does not grant any rights to any user of the program
  ~            with regards to rights under trademark law for use of the trade names
  ~            or trademarks of eGovernments Foundation.
  ~
  ~   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
  --%>

<style type="text/css">
#yui-dt0-bodytable, #yui-dt1-bodytable, #yui-dt2-bodytable {
    Width:100%;
} 
.yui-dt-col-NonSorEstdAmt{
	text-align:right;
}
.yui-dt-col-NonSorTaxAmt{
	text-align:right;
}
.yui-dt-col-NonSorTotal{
	text-align:right;
}	
.yui-dt-col-rate{
	text-align:right;
}		
.yui-dt-col-quantity{
	text-align:right;
}
.yui-dt-col-serviceTaxPerc{
	text-align:right;
}

.yui-dt-col-nonSordescription{
	text-align:left;
}
.yui-dt-col-SlNo{
	text-align:left;
}
.yui-dt-col-rate{
	text-align:left;
}
.yui-dt-col-Uom{
	text-align:left;
}
.yui-dt-col-NonSorDelete{
	text-align:left;
}
</style>
<script>

var uomDropdownOptions=[{label:"--- Select ---", value:"0"},
    <s:iterator var="s" value="dropdownData.uomList" status="status">  
    {"label":"<s:property value="%{uomCategory.category}"/> -- <s:property value="%{uom}" />" ,
    "value":"<s:property value="%{id}" />"
    }<s:if test="!#status.last">,</s:if>
    </s:iterator>       
    ]

function calculateNonSOR(elem,recordId){
	if(!checkUptoFourDecimalPlace(elem,dom.get('nonsor_error'),"Unit Rate"))
	  return;
	record=nonSorDataTable.getRecord(recordId);
	dom.get('error'+elem.id).style.display='none';
	if(!validateNumberInTableCell(nonSorDataTable,elem,recordId)) return;
	if(elem.value!=''){ 
		if(!validateNonSORDescription(recordId)) return;
		if(!validateNonSorUom(recordId)) return;
	}
}

function recalculateNonSorTotalsOnDelete(record){
	if(dom.get("nonsorrate"+record.getId()).value !="" && dom.get("nonsorquantity"+record.getId()).value!=""){
	  dom.get("nonSorEstTotal").innerHTML=roundTo(getNumericValueFromInnerHTML("nonSorEstTotal") -getNumber(record.getData("NonSorEstdAmt")));
	  dom.get("nonSorTaxTotal").innerHTML=roundTo(getNumericValueFromInnerHTML("nonSorTaxTotal") - getNumber(record.getData("NonSorTaxAmt")));
	  dom.get("nonSorGrandTotal").innerHTML=roundTo(getNumericValueFromInnerHTML("nonSorGrandTotal") - getNumber(record.getData("NonSorTotal")));
	  document.getElementById("estimateValue").value=roundTo(eval(document.getElementById("grandTotal").innerHTML)+eval(document.getElementById("nonSorGrandTotal").innerHTML)+eval(document.getElementById("overHeadTotalAmnt").innerHTML));
	}
}

function createTextBoxFormatter(size,maxlength){
var textboxFormatter = function(el, oRecord, oColumn, oData) {
    var value = (YAHOO.lang.isValue(oData))?oData:"";
    var id="nonsor"+oColumn.getKey()+oRecord.getId();
    var fieldName = "nonSorActivities[" + oRecord.getCount() + "]." + oColumn.getKey();
    markup="<input type='text' id='"+id+"' name='"+fieldName+"' size='"+size+"' maxlength='"+maxlength+"' class='selectamountwk' onblur='calculateNonSOR(this,\""+oRecord.getId()+"\");' /><span id='error"+id+"' style='display:none;color:red;font-weight:bold'>&nbsp;x</span>";
    el.innerHTML = markup;
}
return textboxFormatter;
}
var textboxFormatter = createTextBoxFormatter(10,13);
var stFormatter = createTextBoxFormatter(5,5);

var textboxDescFormatter = function(el, oRecord, oColumn, oData) {
   var fieldName = "nonSorActivities[" + oRecord.getCount() + "]." + "nonSor.description";
	markup="<input type='text' id='"+oColumn.getKey()+oRecord.getId()+"' class='selectmultilinewk' size='90' maxlength='4000' name='"+fieldName+"' onblur='validateNonSORDescription(\""+oRecord.getId()+"\");'/>"
	el.innerHTML = markup;	 	
}

function createNonSorHiddenFormatter(el, oRecord, oColumn, oData){
var hiddenFormatter = function(el, oRecord, oColumn, oData) {
    var value = (YAHOO.lang.isValue(oData))?oData:"";
    var id=oColumn.getKey()+oRecord.getId();
    var fieldName = "nonSorActivities[" + oRecord.getCount() + "]." + "nonSor.uom.id";
    var fieldValue=value;
    markup="<input type='hidden' id='"+id+"' name='"+fieldName+"' value='"+fieldValue+"' /><span id='error"+id+"' style='display:none;color:red;font-weight:bold'>&nbsp;x</span>";
    el.innerHTML = markup;
}
return hiddenFormatter;
}
var nonSorHiddenFormatter = createNonSorHiddenFormatter(10,10);
var nonSorDataTable;
var makeNonSORDataTable = function() {
	var cellEditor=new YAHOO.widget.TextboxCellEditor()
	var nonSorColumnDefs = [ 
		{key:"NonSorId", hidden:true,sortable:false, resizeable:false} ,
		{key:"SlNo", label:'Sl No', width:50,sortable:false, resizeable:false},
		{key:"nonSordescription", width:450,label:'Description<span class="mandatory"></span>', formatter:textboxDescFormatter, sortable:false, resizeable:false},		
		{key:"Uom", label:'UOM<span class="mandatory"></span>', width:250,formatter:"dropdown", dropdownOptions:uomDropdownOptions},
		{key:"nonSorUom", hidden:true, formatter:nonSorHiddenFormatter, sortable:false, resizeable:false},
		{key:"rate",label:'Unit Rate<span class="mandatory"></span>',width:150, formatter:textboxFormatter,sortable:false, resizeable:false},
		<s:if test="%{mode!='view'}">
		{key:'NonSorDelete',label:'Delete',width:60,formatter:createDeleteImageFormatter("${pageContext.request.contextPath}")}  
	    </s:if>
	];
	var nonSorDataSource = new YAHOO.util.DataSource(); 
	nonSorDataTable = new YAHOO.widget.DataTable("nonSorTable",nonSorColumnDefs, nonSorDataSource, {MSG_EMPTY:"<s:text name='estimate.nonsor.initial.table.message'/>"});
	nonSorDataTable.subscribe("cellClickEvent", nonSorDataTable.onEventShowCellEditor); 
	nonSorDataTable.on('cellClickEvent',function (oArgs) {
		var target = oArgs.target;
		var record = this.getRecord(target);
		var column = this.getColumn(target);
		if (column.key == 'NonSorDelete') { 			
				this.deleteRow(record);
				allRecords=this.getRecordSet();
				for(i=0;i<allRecords.getLength();i++){
					this.updateCell(this.getRecord(i),this.getColumn('SlNo'),""+(i+1));
				}
		}        
	});
	
	nonSorDataTable.on('dropdownChangeEvent', function (oArgs) {
	
	    var record = this.getRecord(oArgs.target);
        var column = this.getColumn(oArgs.target);
        if(column.key=='Uom'){
            var selectedIndex=oArgs.target.selectedIndex;
            this.updateCell(record,this.getColumn('nonSorUom'),uomDropdownOptions[selectedIndex].value);
            if(!validateNonSorUom(record)) return;
        }
	});
		return {
	    oDS: nonSorDataSource,
	    oDT: nonSorDataTable
	};        

}

function validateNonSORDescription(recordId){
	record=nonSorDataTable.getRecord(recordId);
	if(dom.get("nonSordescription"+record.getId()).value==''){  		
  		document.getElementById("nonsor_error").innerHTML='<s:text name="estimate.nonsor.description.null"/>';
  		document.getElementById("nonsor_error").style.display='';
  		dom.get("nonsorrate"+record.getId()).value='';
      	return false;
  	}
  	else{
       	 document.getElementById("nonsor_error").style.display='none';
       	 document.getElementById("nonsor_error").innerHTML='';	
       	 }
	return true;   
}

function validateNonSorUom(recordId){
	record=nonSorDataTable.getRecord(recordId);
	if((dom.get("nonSorUom"+record.getId()).value=='0' || dom.get("nonSorUom"+record.getId()).value=='') && dom.get("nonsorrate"+record.getId()).value!=''){  		
  		document.getElementById("nonsor_error").innerHTML='<s:text name="estimate.nonsor.uom.null"/>';
  		document.getElementById("nonsor_error").style.display='';
  		dom.get("nonsorrate"+record.getId()).value='';
      	return false;
  	}
  	else{
       	 document.getElementById("nonsor_error").style.display='none';
       	 document.getElementById("nonsor_error").innerHTML='';	
       	 }
	return true;   
}

function resetNonSorTable(){
	nonSorDataTable.deleteRows(0,nonSorDataTable.getRecordSet().getLength());
	
}

</script>		

<div id="nonSorHeaderTable" class="panel panel-primary" data-collapsed="0" style="text-align:left">
	<div class="panel-heading">
		<div class="panel-title">
		   <s:text name="estimate.master.nonsor"/>
		   <div class="pull-right">
		   <s:if test="%{mode!='view'}">
		   <a id="addnonSorRow" href="javascript:void(0);" class="btn btn-primary" onclick="nonSorDataTable.addRow({SlNo:nonSorDataTable.getRecordSet().getLength()+1});return false;">
	   	      <s:text name="estimate.master.addnonsor"/>
	   	   </a>
	   	   </s:if>
		   </div>
		</div>
	</div>
	<div class="panel-body">		
		<div class="alert alert-danger" id="nonsor_error" style="display:none;"></div>
		<div class="form-group">
	    	<div class="yui-skin-sam">
               <div id="nonSorTable"></div>                    	
               <div id="nonSorTotals"></div>  
        	</div>
	    </div>
	</div>
</div>

<script>
		makeNonSORDataTable();
		<s:iterator var="nonsoriterator" value="NonSORActivities" status="row_status">
            nonSorDataTable.addRow({NonSorID:'<s:property value="nonSor.id"/>',
                                    SlNo:'<s:property value="#row_status.count"/>',
                                    nonSordescription:'<s:property value="nonSor.descriptionJS" escapeXml="false"/>',
                                    Uom:'<s:property value="nonSor.uom.id"/>',
                                    nonSorUom:'<s:property value="nonSor.uom.id"/>',
                                    rate:'<s:property value="rate"/>',
                                    Delete:'X'});
        var record = nonSorDataTable.getRecord(parseInt('<s:property value="#row_status.index"/>'));
    
        var column = nonSorDataTable.getColumn('nonSordescription');
        // Important to use escape=false. Otherwise struts will replace double quotes with &quote;  
        dom.get(column.getKey()+record.getId()).value = '<s:property value="nonSor.descriptionJS" escapeXml="false"/>';
        
        var column = nonSorDataTable.getColumn('rate');  
        dom.get("nonsor"+column.getKey()+record.getId()).value = '<s:property value="rate"/>';
        
      
        column = nonSorDataTable.getColumn('Uom');
        for(i=0; i < uomDropdownOptions.length; i++) {
            if (uomDropdownOptions[i].value == '<s:property value="nonSor.uom.id"/>') {
                nonSorDataTable.getTdEl({record:record, column:column}).getElementsByTagName("select").item(0).selectedIndex = i;
            }
        }
        </s:iterator>
        <s:if test="%{mode=='view'}">
        for(i=0;i<document.estimateTemplateForm.elements.length;i++){
        	document.estimateTemplateForm.elements[i].disabled=true;
        	document.estimateTemplateForm.elements[i].readonly=true;
        } 
        </s:if>
</script>