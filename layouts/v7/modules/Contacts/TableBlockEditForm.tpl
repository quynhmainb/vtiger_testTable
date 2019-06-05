<div class='fieldBlockContainer' data-block="{$BLOCK_LABEL}">
    <h4 class='fieldBlockHeader'>{vtranslate($BLOCK_LABEL, $MODULE)}</h4>
    <hr>
    <table class="table table-borderless">
        <tr class="tableBlockHeader">
            {assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
            {assign var=COUNT value=$SELECTED_FIELDS_MODEL|count}
            {assign var=CELLWIDTH value=98/$COUNT}
            <td colspan="4" style="padding: 0px;">
                <div style="overflow-x: auto; overflow-y: hidden" class="scollBarData">
                    <table class="table table-bordered table-condensed listViewEntriesTable">
                        <thead>
                        <tr class="listViewHeaders">
                            <th width="2%">&nbsp;</th>

                            {foreach item=FIELD_MODEL from=$BLOCK_FIELDS name=selected_fields}
                                {if $FIELD_MODEL->isEditable() eq 'true'}
                                    <th {if $FIELD_MODEL->get('uitype') eq '56'} width="5%" {assign var=CELLWIDTH value=98/($COUNT-1)} {else} width="{$CELLWIDTH}%" style="min-width: 180px;" class="fieldLabel {$WIDTHTYPE}" {/if}   {if $FIELD_MODEL@last} colspan="2" {/if}><strong>{if $FIELD_MODEL->isMandatory() eq true} <span class="redColor">*</span> {/if}{vtranslate($FIELD_MODEL->get('label'), $SOURCE_MODULE)}</strong></th>
                                    <script>
                                        jQuery('#selected_fields'+{$BLOCK_ID}).val(jQuery('#selected_fields'+{$BLOCK_ID}).val()+',{$FIELD_MODEL->getFieldName()}');
                                        {if $FIELD_MODEL->get('uitype') eq '33'}
                                        jQuery('#multipicklist_fields'+{$BLOCK_ID}).val(jQuery('#multipicklist_fields'+{$BLOCK_ID}).val()+',{$FIELD_MODEL->getFieldName()}');
                                        {elseif $FIELD_MODEL->getFieldDataType() eq 'reference'}
                                        jQuery('#reference_fields'+{$BLOCK_ID}).val(jQuery('#reference_fields'+{$BLOCK_ID}).val()+',{$FIELD_MODEL->getFieldName()}');
                                        {/if}
                                    </script>
                                {/if}
                            {/foreach}
                        </tr>
                        </thead>
                        <tbody class="ui-sortable" id="dataTable{$BLOCK_ID}" data-block-id="{$BLOCK_ID}">
                        <tr class="blockSortableClone hide">
                            <td width="2%">
                                <img title="Drag" class="alignTop" src="layouts/vlayout/skins/images/drag.png">
                                <input type="hidden" value="0" class="rowNumber">
                            </td>
                            {foreach item=FIELD_MODEL from=$SELECTED_FIELDS_MODEL name=selected_fields}
                                {if $FIELD_MODEL->isEditable() eq 'true'}
                                    {assign var=FIELD_MODEL value=$FIELD_MODEL->set('fieldvalue',$FIELD_MODEL->getDefaultFieldValue())}
                                    <td class="fieldValue">
                                        {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$SOURCE_MODULE) BLOCK_FIELDS=$SELECTED_FIELDS_MODEL MODULE=$SOURCE_MODULE}
                                        {if $smarty.foreach.selected_fields.iteration eq $SELECTED_FIELDS_MODEL|count}
                                            <div class="actions pull-right" style="padding-top:7px; padding-right:10px;">
                                                &nbsp;<a class="deleteRecordButton"><i title="{vtranslate('LBL_DELETE', $MODULE)}" class="fa fa-trash alignMiddle"></i></a>
                                            </div>
                                        {/if}
                                    </td>
                                {/if}
                            {/foreach}
                        </tr>
                        {if $BLOCKS_DATA|count >0}
                            <input type="hidden" name="tableblocks[{$BLOCK_ID}]">
                            {foreach item=ROW_DATA key=ROW_ID from=$BLOCKS_DATA name=block_data}
                                {assign var="rowNo" value=$smarty.foreach.block_data.iteration}
                                <tr id="row{$rowNo}" class="rowDataItem blockSortable">
                                    <td width="2%">
                                        <img title="Drag" class="alignTop" src="layouts/vlayout/skins/images/drag.png">
                                        <input type="hidden" value="{$rowNo}" class="rowNumber">
                                    </td>
                                    {foreach item=FIELD_MODEL from=$SELECTED_FIELDS_MODEL name=selected_fields}
                                        {assign var=FIELD_MODEL value=$FIELD_MODEL->set('fieldvalue',$ROW_DATA[$FIELD_MODEL->getFieldName()])}
                                        {if $FIELD_MODEL->isEditable() eq 'true'}
                                            <td class="fieldValue" {if $FIELD_MODEL->get('uitype') eq '56'} width="5%" {else} width="{$CELLWIDTH}%" style="min-width: 180px;" {/if}>
                                                {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$SOURCE_MODULE) BLOCK_FIELDS=$SELECTED_FIELDS_MODEL MODULE=$SOURCE_MODULE}
                                                {if $smarty.foreach.selected_fields.iteration eq $SELECTED_FIELDS_MODEL|count}
                                                    <div class="actions pull-right" style="padding-top:7px; padding-right:10px;">
                                                        &nbsp;<a class="deleteRecordButton"><i title="{vtranslate('LBL_DELETE', $MODULE)}" class="fa fa-trash alignMiddle"></i></a>
                                                    </div>
                                                {/if}
                                            </td>
                                        {/if}
                                    {/foreach}
                                </tr>
                            {/foreach}
                        {/if}
                        {if $TOTAL_FIELDS_MAPPING|count >0}
                            <tr class="blockTotalFiels">
                                <td class="fieldValue" width="2%">
                                    <strong>Total</strong>
                                </td>
                                {foreach item=FIELD_MODEL from=$SELECTED_FIELDS_MODEL name=selected_fields}
                                    {if $FIELD_MODEL->isEditable() eq 'true'}
                                        <td class="fieldValue">
                                            {assign var=TOTAL_FIELD_NAME value=$TOTAL_FIELDS_MAPPING[$FIELD_MODEL->getFieldName()]}
                                            {if $TOTAL_FIELD_NAME}
                                                <input type="text" name="{$TOTAL_FIELD_NAME}" value="{$RECORD_MODEL->get($TOTAL_FIELD_NAME)}" style="box-shadow:0 0 0 0 #FFFFFF inset !important; border: 0; background: #FFFFFF; font-weight: bold;" readonly/>
                                            {else}
                                                &nbsp;
                                            {/if}
                                        </td>
                                    {/if}
                                {/foreach}
                            </tr>
                        {/if}
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
        <tr class="tableBlockHeader">
            <td colspan="4">
                <button class="btn btn-success" type="button" id="btnAddRowData{$BLOCK_ID}"><i class="icon-plus"></i> &nbsp;<strong>{vtranslate('LBL_ADD')}</strong></button>
                <input type="hidden" id="selected_fields{$BLOCK_ID}" />
                <input type="hidden" id="multipicklist_fields{$BLOCK_ID}" />
                <input type="hidden" id="reference_fields{$BLOCK_ID}" />
                <input type="hidden" id="total_fields_mapping{$BLOCK_ID}" data-value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($TOTAL_FIELDS_MAPPING))}"/>
                <input type="hidden" name="table_block_data" value="1" />
            </td>
        </tr>
    </table>
</div>
