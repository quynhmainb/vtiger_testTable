{assign var=BLOCK value=$BLOCK_LIST[$BLOCK_LABEL_KEY]}
<div class="block block_{$BLOCK_LABEL_KEY}" data-block="{$BLOCK_LABEL_KEY}" data-blockid="{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}">
    {assign var=IS_HIDDEN value=$BLOCK->isHidden()}
    {assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
    <input type=hidden name="timeFormatOptions" data-value='{$DAY_STARTS}' />
    <div>
        <h4 class="textOverflowEllipsis maxWidth50">
            <img class="cursorPointer alignMiddle blockToggle {if !($IS_HIDDEN)} hide {/if}" src="{vimage_path('arrowRight.png')}" data-mode="hide" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}>
            <img class="cursorPointer alignMiddle blockToggle {if ($IS_HIDDEN)} hide {/if}" src="{vimage_path('arrowdown.png')}" data-mode="show" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}>&nbsp;
            {vtranslate({$BLOCK_LABEL_KEY},{$MODULE_NAME})}
        </h4>
    </div>
    <hr>
    <div class="blockData">
        <table class="table detailview-table no-border">
            <tr class="tableBlockHeader">
                {assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
                <td colspan="4" style="padding: 0px;">
                    <div style="overflow-x: auto; overflow-y: hidden" class="scollBarData">
                        <table class="table table-bordered table-condensed listViewEntriesTable" >
                            <thead>
                            <tr class="listViewHeaders">
                                {*<th width="2%">&nbsp;*}
                                {*<input type="hidden" id="selected_fields{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}" />*}
                                {*<input type="hidden" id="multipicklist_fields{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}" />*}
                                {*</th>*}
                                {foreach item=FIELD_MODEL key=FIELD_NAME from=$FIELD_MODEL_LIST}
                                {assign var=fieldDataType value=$FIELD_MODEL->getFieldDataType()}
                                    <th {if $FIELD_MODEL->get('uitype') eq '56'} width="5%" {else}style="min-width: 180px;"{/if} class="{$WIDTHTYPE}" {if $FIELD_MODEL@last} colspan="2" {/if}><strong>{if $FIELD_MODEL->isMandatory() eq true} <span class="redColor">*</span> {/if}{vtranslate($FIELD_MODEL->get('label'), $SOURCE_MODULE)}</strong></th>
                                    <script>
                                        jQuery('#selected_fields'+{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}).val(jQuery('#selected_fields'+{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}).val()+',{$FIELD_MODEL->getFieldName()}');
                                        {if $FIELD_MODEL->get('uitype') eq '33'}
                                        jQuery('#multipicklist_fields'+{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}).val(jQuery('#multipicklist_fields'+{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}).val()+',{$FIELD_MODEL->getFieldName()}');
                                        {/if}
                                    </script>
                                {/foreach}
                            </tr>
                            </thead>
                            <tbody class="ui-sortable" id="dataTable{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}" data-block-id="{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}">
                            {if $BLOCKS_DATA|count >0}
                                {foreach item=ROW_DATA key=ROW_ID from=$BLOCKS_DATA name=block_data}
                                    {*{assign var="rowNo" value=$smarty.foreach.block_data.iteration}*}
                                    <tr id="row{$ROW_ID}" class="rowDataItem blockSortable" >
                                        {*<td class="fieldValue" width="2%">*}
                                        {*<img title="Drag" class="alignTop" src="layouts/vlayout/skins/images/drag.png">*}
                                        {*<input type="hidden" value="{$ROW_ID}" class="rowNumber">*}
                                        {*</td>*}
                                        {foreach item=FIELD_MODEL from=$SELECTED_FIELDS_MODEL name=selected_fields}
                                            {assign var=FIELD_MODEL value=$FIELD_MODEL->set('fieldvalue',$ROW_DATA[$FIELD_MODEL->getFieldName()])}
                                            {if $FIELD_MODEL->get('uitype') neq "83"}
                                                <td class="fieldValue" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20'} colspan="3" {/if}>
                                                    <div class="row-fluid">
                                             <span class="value" data-field-type="{$FIELD_MODEL->getFieldDataType()}" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20' or $FIELD_MODEL->get('uitype') eq '21'} style="white-space:normal;" {/if}>
                                                {$FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue'))}
                                             </span>
                                                        {if $FIELD_MODEL->isEditable() eq 'true' && ($FIELD_MODEL->getFieldDataType()!=Vtiger_Field_Model::REFERENCE_TYPE)}
                                                            <span class="hide edit">
                                                    {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$SOURCE_MODULE) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$SOURCE_MODULE}

                                                                <br />
                                                    <a href="javascript:void(0);" data-field-name="{$FIELD_MODEL->getFieldName()}{if $FIELD_MODEL->get('uitype') eq '33'}[]{/if}" data-row-id="{$ROW_ID}" data-block-id="{$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}" data-record-id="{$RECORD_ID}" class="hoverEditSave">{vtranslate('LBL_SAVE')}</a> |
                                                    <a href="javascript:void(0);" class="hoverEditCancel">{vtranslate('LBL_CANCEL')}</a>
                                                </span>
                                                        {/if}
                                                    </div>
                                                </td>
                                            {/if}
                                        {/foreach}
                                    </tr>
                                {/foreach}
                            {else}
                            {/if}
                            {if $TOTAL_FIELDS_MAPPING|count >0}
                                <tr class="blockTotalFiels">
                                    {*<td class="fieldValue" width="2%">*}
                                    {*<strong>Total</strong>*}
                                    {*</td>*}
                                    {foreach item=FIELD_MODEL from=$SELECTED_FIELDS_MODEL name=selected_fields}
                                        {if $FIELD_MODEL->isEditable() eq 'true'}
                                            <td class="fieldValue">
                                                {assign var=TOTAL_FIELD_NAME value=$TOTAL_FIELDS_MAPPING[$FIELD_MODEL->getFieldName()]}
                                                {if $TOTAL_FIELD_NAME}
                                                    <span class="value" id="{$TOTAL_FIELD_NAME}" style="font-weight: bold;">
                                                {CurrencyField::convertToUserFormat($RECORD_MODEL->get($TOTAL_FIELD_NAME), null, true)}
                                            </span>
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
        </table>
    </div>
</div>
