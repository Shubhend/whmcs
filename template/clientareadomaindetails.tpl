{if $registrarcustombuttonresult=="success"}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.moduleactionsuccess textcenter=true}
{elseif $registrarcustombuttonresult}
    {include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed textcenter=true}
{/if}

{if $unpaidInvoice}
    <div class="alert alert-{if $unpaidInvoiceOverdue}danger{else}warning{/if}" id="alert{if $unpaidInvoiceOverdue}Overdue{else}Unpaid{/if}Invoice">
        <div class="pull-right">
            <a href="viewinvoice.php?id={$unpaidInvoice}" class="btn btn-xs btn-default">
                {lang key='payInvoice'}
            </a>
        </div>
        {$unpaidInvoiceMessage}
    </div>
{/if}


{php}  include(getcwd().'/manager/function.php');  {/php}

<div class="tab-content margin-bottom">


    <div class="tab-pane fade in " id="tabAuth">

        <h3>Auth Code</h3>

        <br>

        <h2 class="text-center"> AuthCode: <span class="label label-success">



{php}

    $pass = substr(str_shuffle("0123456789abcdefghijklmnopqrstvwxyz"), 0, 13);


    $pass1 = substr(str_shuffle("@FREO"), 0, 5);
    echo $pass1.$pass;

{/php}
</span></h2>


        <h2>Contact Support team for transfer away. Thank you.
        </h2>
        <br>


    </div>

    <div class="tab-pane fade in " id="tabblogger">

        {php}



            if(isset($_POST['bloggerip'])){

            blogger($_POST['domain'],$_POST);


            }
            $domain=$GLOBALS['smarty']->getTemplateVars('domain');

            $alldatablogger= getdata($domain,'bloggerip');






        {/php}


        <h3>Blogger DNS    {php}


                $domain=$GLOBALS['smarty']->getTemplateVars('domain');


                $currentstatus=getstatus($domain,'bloggerip');


                if($currentstatus==0){
                echo '<div class="badge badge-danger badge-error-alt" style="background:red;">Pending</div>';
                                                                                                           }else{

                                                                                                           echo '<div class="badge badge-danger badge-error-alt" style="background:green;">Completed</div>';
                }




            {/php}
        </h3>


        <div class="alert alert-info">
            Blogger IP already set by default.
        </div>







        <form method="post" action="#tabblogger">



            <table class="table" >
                <thead>
                <tr>
                    <th scope="col">CNAME</th>
                    <th scope="col">Destination</th>


                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>www</td>
                    <td>ghs.google.com
                    </td>
                </tr>

                <tr>
                    <td>  <input type="text" name="name" value="{php} echo $alldatablogger['name']; {/php}"> </td>
                    <td>  <input type="text" name="destination" value="{php}    echo $alldatablogger['destination'];  {/php}">  </td>
                </tr>

                </tbody>

            </table>

            <input type="hidden" name="domain" value="{php} echo $GLOBALS['smarty']->getTemplateVars('domain'); {/php}">

            <input type="submit" class="btn btn-lg btn-primary" name="bloggerip" value="Submit">


        </form>




    </div>


    <div class="tab-pane fade in " id="tabdnsmanagement">


        {php}

            if(isset($_POST['dnssubmit'])){


            dnsdata($_POST['domain'],$_POST);

            header("Refresh:0");


            }


            $domain=$GLOBALS['smarty']->getTemplateVars('domain');

            $alldatadns= getdata($domain,'dnsrecord');


            $totalrecord=count($alldatadns['host']);

        {/php}


        <h3>DNS Management         {php}


                $domain=$GLOBALS['smarty']->getTemplateVars('domain');


                $currentstatus=getstatus($domain,'dnsrecord');


                if($currentstatus==0){
                echo '<div class="badge badge-danger badge-error-alt" style="background:red;">Pending</div>';
                                                                                                           }else{

                                                                                                           echo '<div class="badge badge-danger badge-error-alt" style="background:green;">Completed</div>';
                }




            {/php}

        </h3>

        <div class="alert alert-info">
            You can manage DNS records at AmbitionHost.Then default nameserver will be automatically applied.
        </div>


        <div class="table-container">
            <button id="addnew" type="button" class="btn btn-primary" >Add New Record</button>

            <form method="post" action="#tabdnsmanagement">



                <table class="table" >
                    <thead>
                    <tr>
                        <th scope="col">HostName</th>
                        <th scope="col">Type</th>
                        <th scope="col">Destination</th>
                        <th>Action</th>

                    </tr>
                    </thead>
                    <tbody id='record_row34'>

                    {php}



                        for($i=0;$i<$totalrecord;$i++){

                    {/php}

                    <tr>
                        <td>  <input type="text" name="host[]" value="{php} echo  $alldatadns['host'][$i] {/php}"> </td>
                        <td>  <select name="type[]">
                                <option value="A"  {php} if($alldatadns['type'][$i]=='A') echo "selected"; {/php} >A</option>
                                <option value="TXT" {php} if($alldatadns['type'][$i]=='TXT') echo "selected"; {/php}  >TXT</option>
                                <option value="MX" {php} if($alldatadns['type'][$i]=='MX') echo "selected"; {/php}  >MX</option>
                                <option value="CNAME" {php} if($alldatadns['type'][$i]=='CNAME') echo "selected"; {/php}>CNAME</option>
                                <option value="AAAA" {php} if($alldatadns['type'][$i]=='AAAA') echo "selected"; {/php}>AAAA</option>
                                <option value="URL_REDIRECT" {php} if($alldatadns['type'][$i]=='URL_REDIRECT') echo "selected"; {/php}>URL Redirect</option>



                            </select>

                        </td>
                        <td>  <input type="text" name="record[]" value="{php} echo  $alldatadns['record'][$i] {/php}">  </td>
                        <td>  <a href="#" onclick="$(this).parent().parent().remove();">Remove</a>   </td>
                    </tr>
                    {php}

                        }
                    {/php}

                    </tbody>
                </table>
                <input type="hidden" name="domain" value="{php} echo $GLOBALS['smarty']->getTemplateVars('domain'); {/php}">

                <input type="submit" class="btn btn-lg btn-primary" name="dnssubmit" value="Submit">


            </form>


        </div>

        <script>

            $('#addnew').click(function(event){

                $("#record_row34").append(' <tr>'
                    +'<td>  <input type="text" name="host[]"> </td>'
                    +'<td>  <select name="type[]"> <option value="A">A</option> <option value="TXT">TXT</option> <option value="MX">MX</option> <option value="CNAME">CNAME</option>  <option value="AAAA">AAAA</option>  <option value="URL_REDIRECT">URL Redirect</option>  </select> </td>'
                    +'<td>  <input type="text" name="record[]" >  </td>'
                    +'<td>  <a href="#" onclick="$(this).parent().parent().remove();">Remove</a>   </td>'
                    +'</tr>');

            });

        </script>


    </div>


    <div class="tab-pane fade in active" id="tabOverview">

        {if $alerts}
            {foreach $alerts as $alert}
                {include file="$template/includes/alert.tpl" type=$alert.type msg="<strong>{$alert.title}</strong><br>{$alert.description}" textcenter=true}
            {/foreach}
        {/if}

        {if $systemStatus != 'Active'}
            <div class="alert alert-warning text-center" role="alert">
                {$LANG.domainCannotBeManagedUnlessActive}
            </div>
        {/if}

        <h3>{$LANG.overview}</h3>

        {if $lockstatus eq "unlocked"}
            {capture name="domainUnlockedMsg"}<strong>{$LANG.domaincurrentlyunlocked}</strong><br />{$LANG.domaincurrentlyunlockedexp}{/capture}
            {include file="$template/includes/alert.tpl" type="error" msg=$smarty.capture.domainUnlockedMsg}
        {/if}

        <div class="row">
            <div class="col-sm-offset-1 col-sm-5">
                <h4><strong>{$LANG.clientareahostingdomain}:</strong></h4> <a href="http://{$domain}" target="_blank">{$domain}</a>
            </div>
            <div class="col-sm-5">
                <h4><strong>{$LANG.firstpaymentamount}:</strong></h4> <span>{$firstpaymentamount}</span>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-1 col-sm-5">
                <h4><strong>{$LANG.clientareahostingregdate}:</strong></h4> <span>{$registrationdate}</span>
            </div>
            <div class="col-sm-6">
                <h4><strong>{$LANG.recurringamount}:</strong></h4> {$recurringamount} {$LANG.every} {$registrationperiod} {$LANG.orderyears}
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-1 col-sm-5">
                <h4><strong>{$LANG.clientareahostingnextduedate}:</strong></h4> {$nextduedate}
            </div>
            <div class="col-sm-6">
                <h4><strong>{$LANG.orderpaymentmethod}:</strong></h4> {$paymentmethod}
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-1 col-sm-5">
                <h4><strong>{$LANG.clientareastatus}:</strong></h4> {$status}
            </div>
        </div>
        {if $sslStatus}
            <div class="row">
                <div class="col-sm-offset-1 col-sm-5{if $sslStatus->isInactive()} ssl-inactive{/if}">
                    <h4><strong>{$LANG.sslState.sslStatus}</strong></h4> <img src="{$sslStatus->getImagePath()}" width="16"> {$sslStatus->getStatusDisplayLabel()}
                </div>
                {if $sslStatus->isActive()}
                    <div class="col-sm-6">
                        <h4><strong>{$LANG.sslState.startDate}</strong></h4> {$sslStatus->startDate->toClientDateFormat()}
                    </div>
                {/if}
            </div>
            {if $sslStatus->isActive()}
                <div class="row">
                    <div class="col-sm-offset-1 col-sm-5">
                        <h4><strong>{$LANG.sslState.issuerName}</strong></h4> {$sslStatus->issuerName}
                    </div>
                    <div class="col-sm-6">
                        <h4><strong>{$LANG.sslState.expiryDate}</strong></h4> {$sslStatus->expiryDate->toClientDateFormat()}
                    </div>
                </div>
            {/if}
        {/if}

        {if $registrarclientarea}
            <div class="moduleoutput">
                {$registrarclientarea|replace:'modulebutton':'btn'}
            </div>
        {/if}

        {foreach $hookOutput as $output}
            <div>
                {$output}
            </div>
        {/foreach}

        <br />

        {if $canDomainBeManaged
        and (
        $managementoptions.nameservers or
        $managementoptions.contacts or
        $managementoptions.locking or
        $renew)}
            {* No reason to show this section if nothing can be done here! *}

            <h4>{$LANG.doToday}</h4>

            <ul>
                {if $systemStatus == 'Active' && $managementoptions.nameservers}
                    <li>
                        <a class="tabControlLink" data-toggle="tab" href="#tabNameservers">
                            {$LANG.changeDomainNS}
                        </a>
                    </li>
                {/if}
                {if $systemStatus == 'Active' && $managementoptions.contacts}
                    <li>
                        <a href="clientarea.php?action=domaincontacts&domainid={$domainid}">
                            {$LANG.updateWhoisContact}
                        </a>
                    </li>
                {/if}
                {if $systemStatus == 'Active' && $managementoptions.locking}
                    <li>
                        <a class="tabControlLink" data-toggle="tab" href="#tabReglock">
                            {$LANG.changeRegLock}
                        </a>
                    </li>
                {/if}
                {if $renew}
                    <li>
                        <a href="{routePath('domain-renewal', $domain)}">
                            {$LANG.renewYourDomain}
                        </a>
                    </li>
                {/if}
            </ul>

        {/if}

    </div>
    <div class="tab-pane fade" id="tabAutorenew">

        <h3>{$LANG.domainsautorenew}</h3>

        {if $changeAutoRenewStatusSuccessful}
            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
        {/if}

        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainrenewexp}

        <br />

        <h2 class="text-center">{$LANG.domainautorenewstatus}: <span class="label label-{if $autorenew}success{else}danger{/if}">{if $autorenew}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</span></h2>

        <br />
        <br />

        <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabAutorenew">
            <input type="hidden" name="id" value="{$domainid}">
            <input type="hidden" name="sub" value="autorenew" />
            {if $autorenew}
                <input type="hidden" name="autorenew" value="disable">
                <p class="text-center">
                    <input type="submit" class="btn btn-lg btn-danger" value="{$LANG.domainsautorenewdisable}" />
                </p>
            {else}
                <input type="hidden" name="autorenew" value="enable">
                <p class="text-center">
                    <input type="submit" class="btn btn-lg btn-success" value="{$LANG.domainsautorenewenable}" />
                </p>
            {/if}
        </form>

    </div>
    <div class="tab-pane fade" id="tabNameservers">




        {php}
            if(isset($_POST['submit'])){


            nameserver($_POST['domain'],$_POST);


            header("Refresh:0");

            }


        {/php}







        <h3>{$LANG.domainnameservers}

            {php}


                $domain=$GLOBALS['smarty']->getTemplateVars('domain');


                $currentstatus=getstatus($domain,'nameserver');


                if($currentstatus==0){
                echo '<div class="badge badge-danger badge-error-alt" style="background:red;">Pending</div>';
                                                                                                           }else{

                                                                                                           echo '<div class="badge badge-danger badge-error-alt" style="background:green;">Completed</div>';
                }




            {/php}
        </h3>

        {if $nameservererror}
            {include file="$template/includes/alert.tpl" type="error" msg=$nameservererror textcenter=true}
        {/if}
        {if $subaction eq "savens"}
            {if $updatesuccess}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
            {elseif $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
            {/if}
        {/if}

        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainnsexp}







        {php}


            $domain=$GLOBALS['smarty']->getTemplateVars('domain');


            $alldata= getdata($domain,'nameserver');




        {/php}


        <script>

            function disableFields(inp,ty){

                if(ty){

                    $("#inputNs1").val('ns1.ambitionhost.org');
                    $("#inputNs2").val('ns2.ambitionhost.org');
                    $("#inputNs3").val('ns3.ambitionhost.org');
                    $("#inputNs4").val('ns4.ambitionhost.org');


                }

            }

        </script>

        <div id="msg">


        </div>

        <form  id="hideform" class="form-horizontal" role="form" method="post" action="#tabNameservers">
            <input type="hidden" name="id" value="{$domainid}" />
            <input type="hidden" name="sub" value="savens" />
            <input type="hidden" name="checksubmit" value="testpost" />
            <input type="hidden" name="domain" id="custom_domain" value=""/>

            <input type="hidden" name="status" id="" value="0"/>

            <div class="radio">
                <label>
                    <input type="radio" id="defr" name="nschoice" value="default" onclick="disableFields('domnsinputs',true)"{if $defaultns} checked{/if} /> {$LANG.nschoicedefault}
                </label>
            </div>
            <div class="radio">
                <label>
                    <input type="radio"   name="nschoice" value="custom" onclick="disableFields('domnsinputs',false)"{if !$defaultns} checked{/if} /> {$LANG.nschoicecustom}
                </label>
            </div>
            <br />
            {php} $i=1;  {/php}
            {for $num=1 to 4}
                <div class="form-group">
                    <label for="inputNs{$num}" class="col-sm-4 control-label">{$LANG.clientareanameserver} {$num}</label>
                    <div class="col-sm-7">
                        <input type="text" name="ns{$num}" class="form-control domnsinputs" id="inputNs{$num}" value="{php}  $vari='ns'.$i;  echo $alldata[$vari];  {/php}" />
                    </div>
                </div>
                {php} $i++;  {/php}
            {/for}
            <p class="text-center">
                <input type="submit" name="submit" class="btn btn-primary" value="{$LANG.changenameservers}" />
            </p>
        </form>



        <script>

            domain=$(".header-lined h1").text().replace("Managing"," ");

            $("#custom_domain").val(domain);

        </script>


    </div>
    <div class="tab-pane fade" id="tabReglock">

        <h3>{$LANG.domainregistrarlock}</h3>

        {if $subaction eq "savereglock"}
            {if $updatesuccess}
                {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
            {elseif $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
            {/if}
        {/if}

        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainlockingexp}

        <br />

        <h2 class="text-center">{$LANG.domainreglockstatus}: <span class="label label-{if $lockstatus == "locked"}success{else}danger{/if}">{if $lockstatus == "locked"}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</span></h2>

        <br />
        <br />

        <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabReglock">
            <input type="hidden" name="id" value="{$domainid}">
            <input type="hidden" name="sub" value="savereglock" />
            {if $lockstatus=="locked"}
                <p class="text-center">
                    <input type="submit" class="btn btn-lg btn-danger" value="{$LANG.domainreglockdisable}" />
                </p>
            {else}
                <p class="text-center">
                    <input type="submit" class="btn btn-lg btn-success" name="reglock" value="{$LANG.domainreglockenable}" />
                </p>
            {/if}
        </form>

    </div>
    <div class="tab-pane fade" id="tabRelease">

        <h3>{$LANG.domainrelease}</h3>

        {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainreleasedescription}

        <form class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
            <input type="hidden" name="sub" value="releasedomain">
            <input type="hidden" name="id" value="{$domainid}">

            <div class="form-group">
                <label for="inputReleaseTag" class="col-xs-4 control-label">{$LANG.domainreleasetag}</label>
                <div class="col-xs-6 col-sm-5">
                    <input type="text" class="form-control" id="inputReleaseTag" name="transtag" />
                </div>
            </div>

            <p class="text-center">
                <input type="submit" value="{$LANG.domainrelease}" class="btn btn-primary" />
            </p>
        </form>

    </div>
    <div class="tab-pane fade" id="tabAddons">

        <h3>{$LANG.domainaddons}</h3>

        <p>
            {$LANG.domainaddonsinfo}
        </p>

        {if $addons.idprotection}
            <div class="row margin-bottom">
                <div class="col-xs-3 col-md-2 text-center">
                    <i class="fas fa-shield-alt fa-3x"></i>
                </div>
                <div class="col-xs-9 col-md-10">
                    <strong>{$LANG.domainidprotection}</strong><br />
                    {$LANG.domainaddonsidprotectioninfo}<br />
                    <form action="clientarea.php?action=domainaddons" method="post">
                        <input type="hidden" name="id" value="{$domainid}"/>
                        {if $addonstatus.idprotection}
                            <input type="hidden" name="disable" value="idprotect"/>
                            <input type="submit" value="{$LANG.disable}" class="btn btn-danger"/>
                        {else}
                            <input type="hidden" name="buy" value="idprotect"/>
                            <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.idprotection}" class="btn btn-success"/>
                        {/if}
                    </form>
                </div>
            </div>
        {/if}
        {if $addons.dnsmanagement}
            <div class="row margin-bottom">
                <div class="col-xs-3 col-md-2 text-center">
                    <i class="fas fa-cloud fa-3x"></i>
                </div>
                <div class="col-xs-9 col-md-10">
                    <strong>{$LANG.domainaddonsdnsmanagement}</strong><br />
                    {$LANG.domainaddonsdnsmanagementinfo}<br />
                    <form action="clientarea.php?action=domainaddons" method="post">
                        <input type="hidden" name="id" value="{$domainid}"/>
                        {if $addonstatus.dnsmanagement}
                            <input type="hidden" name="disable" value="dnsmanagement"/>
                            <a class="btn btn-success" href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.manage}</a> <input type="submit" value="{$LANG.disable}" class="btn btn-danger"/>
                        {else}
                            <input type="hidden" name="buy" value="dnsmanagement"/>
                            <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.dnsmanagement}" class="btn btn-success"/>
                        {/if}
                    </form>
                </div>
            </div>
        {/if}
        {if $addons.emailforwarding}
            <div class="row margin-bottom">
                <div class="col-xs-3 col-md-2 text-center">
                    <i class="fas fa-envelope fa-3x">&nbsp;</i><i class="fas fa-share fa-2x"></i>
                </div>
                <div class="col-xs-9 col-md-10">
                    <strong>{$LANG.domainemailforwarding}</strong><br />
                    {$LANG.domainaddonsemailforwardinginfo}<br />
                    <form action="clientarea.php?action=domainaddons" method="post">
                        <input type="hidden" name="id" value="{$domainid}"/>
                        {if $addonstatus.emailforwarding}
                            <input type="hidden" name="disable" value="emailfwd"/>
                            <a class="btn btn-success" href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.manage}</a> <input type="submit" value="{$LANG.disable}" class="btn btn-danger"/>
                        {else}
                            <input type="hidden" name="buy" value="emailfwd"/>
                            <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.emailforwarding}" class="btn btn-success"/>
                        {/if}
                    </form>
                </div>
            </div>
        {/if}
    </div>
</div>

<script>

    $('.list-group-tab-nav').append('<a menuitemname="Overview" href="/#tabAuth" class="list-group-item" data-toggle="tab" id="Primary_Sidebar-Domain_Details_Management-Overview"> Auth Code</a>');


    $('.list-group-tab-nav').append('<a menuitemname="Overview" href="/#tabNameservers" class="list-group-item" data-toggle="tab" id="Primary_Sidebar-Domain_Details_Management-Overview"> Nameserver</a>');

    $('.list-group-tab-nav').append('<a menuitemname="Overview" href="/#tabdnsmanagement" class="list-group-item" data-toggle="tab" id="Primary_Sidebar-Domain_Details_Management-Overview"> DNS Management</a>');

    $('.list-group-tab-nav').append('<a menuitemname="Overview" href="/#tabblogger" class="list-group-item" data-toggle="tab" id="Primary_Sidebar-Domain_Details_Management-Overview"> Blogger  DNS</a>');

</script>