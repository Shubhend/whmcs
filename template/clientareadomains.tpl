{if $warnings}
    {include file="$template/includes/alert.tpl" type="warning" msg=$warnings textcenter=true}
{/if}
<div class="tab-content">
    <div class="tab-pane fade in active" id="tabOverview">
        {include file="$template/includes/tablelist.tpl" tableName="DomainsList" noSortColumns="0, 1, 6" startOrderCol="2" filterColumn="6"}
        <script type="text/javascript">
            jQuery(document).ready( function ()
            {
                var table = jQuery('#tableDomainsList').removeClass('hidden').DataTable();
                {if $orderby == 'domain'}
                table.order(2, '{$sort}');
                {elseif $orderby == 'regdate' || $orderby == 'registrationdate'}
                table.order(3, '{$sort}');
                {elseif $orderby == 'nextduedate'}
                table.order(4, '{$sort}');
                {elseif $orderby == 'autorenew'}
                table.order(5, '{$sort}');
                {elseif $orderby == 'status'}
                table.order(6, '{$sort}');
                {/if}
                table.draw();
                jQuery('#tableLoading').addClass('hidden');
            });
        </script>
        <form id="domainForm" method="post" action="clientarea.php?action=bulkdomain">
            <input id="bulkaction" name="update" type="hidden" />

            <div class="table-container clearfix">
                <table id="tableDomainsList" class="table table-list hidden">
                    <thead>
                    <tr>
                        <th width="20"></th>

                        <th>{$LANG.orderdomain}</th>
                        <th>{$LANG.regdate}</th>
                        <th>{$LANG.nextdue}</th>
                        <th>{$LANG.domainsautorenew}</th>
                        <th>{$LANG.domainstatus}</th>
                        <th>&nbsp;</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach key=num item=domain from=$domains}
                        <tr onclick="clickableSafeRedirect(event, 'clientarea.php?action=domaindetails&amp;id={$domain.id}', false)">
                            <td>
                                <input type="checkbox" name="domids[]" class="domids stopEventBubble" value="{$domain.id}" />
                            </td>

                            <td><a href="http://{$domain.domain}" target="_blank">{$domain.domain}</a></td>
                            <td><span class="hidden">{$domain.normalisedRegistrationDate}</span>{$domain.registrationdate}</td>
                            <td><span class="hidden">{$domain.normalisedNextDueDate}</span>{$domain.nextduedate}</td>
                            <td>
                                {if $domain.autorenew}
                                    <i class="fas fa-fw fa-check text-success"></i> {$LANG.domainsautorenewenabled}
                                {else}
                                    <i class="fas fa-fw fa-times text-danger"></i> {$LANG.domainsautorenewdisabled}
                                {/if}
                            </td>
                            <td>
                                <span class="label status status-{$domain.statusClass}">{$domain.statustext}</span>
                                <span class="hidden">
                                    {if $domain.expiringSoon}<span>{lang key="domainsExpiringSoon"}</span>{/if}
                                </span>
                            </td>
                            <td>

                                <a class="btn btn-primary"  href="clientarea.php?action=domaindetails&id={$domain.id}#tabNameservers"><i class="glyphicon glyphicon-globe"></i> Manage </a>


                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <div class="text-center" id="tableLoading">
                    <p><i class="fas fa-spinner fa-spin"></i> {$LANG.loading}</p>
                </div>
            </div>
        </form>

        <div class="btn-group margin-bottom">
            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-folder-open"></span> &nbsp; {$LANG.withselected} <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#" id="nameservers" class="setBulkAction"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainmanagens}</a></li>
                <li><a href="#" id="autorenew" class="setBulkAction"><i class="glyphicon glyphicon-refresh"></i> {$LANG.domainautorenewstatus}</a></li>
                <li><a href="#" id="reglock" class="setBulkAction"><i class="glyphicon glyphicon-lock"></i> {$LANG.domainreglockstatus}</a></li>
                <li><a href="#" id="contactinfo" class="setBulkAction"><i class="glyphicon glyphicon-user"></i> {$LANG.domaincontactinfoedit}</a></li>
                {if $allowrenew}
                    <li><a href="#" id="renewDomains" class="setBulkAction"><i class="glyphicon glyphicon-refresh"></i> {lang key='domainmassrenew'}</a></li>
                {/if}
            </ul>
        </div>
    </div>
</div>
