# FRINX Machine Demo Manual

Open your browser (avoid Mozila) and go to the following URL:

https://services.frinx.io/frinxui/

Press the “login” button in the upper right of the screen and authenticate yourself. For credential please contact "info@frinx.io" to access the FRINX Machine instance.

You will see the following **FRINX Machine dashboard**:

![FRINX Machine dashboard](fm_dashboard.png)

## Demo Config Manager UI

1) When at the FRINX Machine main page click on “Explore & configure devices”.
2) Make sure that the device you’re about to configure is installed (if not, install it by clicking on “install”).
3) In this demo we will use the IOS01 device. Click on the configuration button (if “transaction expired” window appears, click on “refresh”).

![FRINX Machine dashboard](install_device.png)

4) Change “enabled” status of Loopback0 interface to “false”
5) Save the changes
6) By clicking on “Calculate diff” you can review all the changes made
7) By clicking on “Dry run” you can see the set of commands used for the change
8) Click on “Commit to network” to apply changes to the device (Now you can see the changes in the Operational data store as well)

![FRINX Machine dashboard](config_dashboard.png)

To revert the changes:

9) Click on “Transactions”
10) Click on “Revert” and then on “Revert changes” to revert changes made to the device configuration

## Demo workflow UI basics

Workflow Builder is the graphical interface of WorkFlow Manager used to create, modify and manage workflows. Workflows are groups of tasks and/or subworkflows that can be used for multiple purposes such as installing/deleting devices, creating loopback interfaces on devices, sending messages and much more. You can create your own workflows or edit existing workflows by adding or removing tasks or subworkflows. Every task and subworkflow placed in workflow has its unique reference alias and you cannot have 2 workflows with same name and version.

### Creating a new workflow

Now we will take a look at how to create a new workflow. The new workflow will be created from template workflow called **http_example_01 / 1** which can be found under explore workflows. If you dont wish to create workflow you can just execute this workflow in explore workflows.

1) The easiest way to create a new workflow is to click on **Create** button in the main page of FRINX Machine.

![FRINX Machine dashboard](WorkFlow_Manager.png)

2) In the **Name** type the name of your workflow (please keep in mind that name of the workflow cannot be later changed). **Description** stands for additional info of the workflow - you can leave it blank. Once the workflow is created **Label** can help you find your workflow in **Explore workflows** faster but you can leave it blank as well. After inserting all data click on **Save changes**.

![FRINX Machine dashboard](create_new_workflov.png)

After saving changes you will be redirected to canvas. Here we will add tasks and subworkflow in our workflow.

![FRINX Machine dashboard](workflow_map.png)

3) Click + on the **http** and **labmda** under **System tasks** and **Post_to_Slack** under **Workflows**. All tasks and subworkflows are added on same place in the canvas so you need to move them to actually see them. For connecting all parts of the workflow hower over OUT/IN where + sign will appear. Connect all parts in this way: START - http - lamda - Post_to_Slack - END. As you can see each task and workflow has its own set of characters after its name - these are reference aliases and work as unique identifier.

![FRINX Machine dashboard](workflow_map_edited.png)

Above every task/workflow you can see 2 squares:

**Update:**

![FRINX Machine dashboard](update.png)

**Remove/Expand:**

![FRINX Machine dashboard](remove_expand.png)

4) **http - adjustment**. This task provides multiple methods for working with data from web pages. Click on update above http task. On the right side you can see General Settings and Input Parameters. Leave **General Setting** the way they are and click on **Input Parameters**. Insert:
```https://jsonplaceholder.typicode.com/todos/${workflow.input.selector}```
in the **URI** and leave other columns unchanged. This set of data will get data from JSON database based on selectors input. Now click on **Save Changes** under **Headers**.

![FRINX Machine dashboard](input_parameters.png)

5) **lambda - adjustment**. Click on **Input parameters** and in the **Lambda value** insert:
```${NAME_OF_HTTP_TASK.output.body}```
In our example the name is **http_1cc1**. In the **Script expression** copy-paste: return JSON.parse($.lambdaValue). Lambda takes data from previous http task and returns parsed data (message text) from JSON. Click on **Save Changes**.

![FRINX Machine dashboard](lambda_task.png)

6) **Post_to_Slack - adjustment**. Click on **Input parameters** and in the **slack_webhook_id** insert T03UXD8N58B/B03VCP8U99P/jermqzN9AkhNgXYIZkP0qLI0. In the **message_text** insert:
```${NAME_OF_LAMBDA_TASK.output.result.title}```
**Post_to_Slack** is a workflow that can be used standalone or as a part of other workflows. This workflow works as as sender of messages to specific destination in Slack. Click on **Save Changes**.

![FRINX Machine dashboard](post_to_slack_task.png)

> **Info**: If you don´t see selector column just click on **Close** under the selector column, click on **Definitions** on the top left, insert the name of your workflow in the **Search by keyword**. and press run workflow under **Actions**.

7) Now the workflow is ready to be executed. Insert a number between 1 - 200  in the **selector** and press **Execute**. Click on **Continue to detail**.

![FRINX Machine dashboard](execute_workflow.png)

8) Now you can see that workflow was executed and every task was completed successfully.

![FRINX Machine dashboard](details_of_workflow.png)

The output (demo Latin JSON) of the workflow in the Slack:

![FRINX Machine dashboard](slack_creenshot.png)

You can visit Slack directly via https://join.slack.com/t/frinx-community/shared_invite/zt-1esnmbq4l-ui9xLCS4zKGHUXZxz~PdrQ to see your own message. We recommend to use the browser version.

## How to create new custom workflow

Now we will take a look at how to create a new workflow. The new workflow will be created from scratch.

1) The easiest way to create a new workflow is to click on **Create** button in the main page of FRINX Machine.

![FRINX Machine dashboard](WorkFlow_Manager.png)

2) In the **Name** type the name of your workflow (please keep in mind that name of the workflow cannot be later changed). **Description** stands for additional info of the workflow - you can leave it blank. Once the workflow is created **Label** can help you find your workflow in **Explore workflows** faster but you can leave it blank as well. After inserting all data click on **Save changes**.

FOTO

3) Click + on the **lambda**, **decision** and **terminate** under **System tasks** and **Device_identification** under **Workflows**. All tasks and subworkflows are added on same place in the canvas so you need to move them to actually see them. For connecting all parts of the workflow hower over OUT/IN where + sign will appear. Connect all parts in this way: START - lambda - decision - (other) with Device_identification and default with terminate. As you can see each task and workflow has its own set of characters after its name - these are reference aliases and work as unique identifier.

![FRINX Machine dashboard](custom_wf_001.PNG)

Above every task/workflow you can see 2 squares:

**Update:**

![FRINX Machine dashboard](update.png)

**Remove/Expand:**

![FRINX Machine dashboard](remove_expand.png)

4) **lambda**. tento task bude robiť rozhodnutie, aký status má zaujať na základa vloženého portu. V tomto príklade budeme uvažovať iba s portami od 10000 do 10004, všetky ostatné budeme ignorovať. Lambda task ako taký nám umožňuje do workflow builderu vložiť malý kód (lambda - funkcia bez mena)

V tomto prípade, ak je zadaný port vyšší alebo rovný 10000 a zároveň menší ako 10005 - zaujmi status "pracuj ďalej" inak / v opačnom pípade zaujmi status - "koniec". Tento status bude výstupom lambdy a vstupom pre ďalší task alebo subworkflow.

-- subworkflov nieje nič iné než klasický workflow s tým rozdielom, že sa daný workflow nachádza vo vnútri iného workflowu. Aj tento workflow ktorý vytvárame môže byť v budúcnosti použitý ako stavebný kameň iného workflowu a stane sa v danom WF subWF... a takto môžeme vrstviť nami už vytvorené workflovy a recyklovať ich :)

v tabe Input parameters vložíme do poľa Lambda value: "${workflow.input.port}" čo v preklade znamená pracuj s tým, čo sa v tomto WF na inpute zadalo do kolónky **port** (viac si o tom povieme neskôr, odsek 7)

do vstupu **Script expression** vložíme malú funkciu ktorej činnosť sme si popísali vyššie.
```
if ($.lambdaValue >= 10000 && $.lambdaValue < 10005) { 
  return {value: 'other'}
} else { 
  return {value: false}
}
```

![FRINX Machine dashboard](lambda_1_body.PNG)

5) **decision**. Decision task robí rozhodnutie, avšak nie úplne tak isto ako lambda spomínaná vyššie. Decision sa spáva ako výhybka na kolajisku, pošle vlak jednou alebo druhou traťou. Nič viac. Na to však potrebuje údaje - tie ktoré nám dodala lambda. V záložke Input parameters zmažeme defaultný parameter foo s hodnotou bar a ponecháme iba parameter param do ktorého vložíme miesto true ${lambda_IkSu.output.result.value} - pozor IkSu ako sa spomínalo vyššie je generované pre odlíšenie jednotlivých taskov a WFs preto ho treba prepísať na aktuálne podmienky. `${lambda_IkSu.output.result.value}` znamená: zober hodnotu z lambda_xyzq ktorá je na výstupe (output) v outpute nájdi result a v ňom value.

ak vstupná hodnota pre decision bude other, pošle flow smerom k Device_identification a ak bude false tak smerom k terminate. Presne ako sme si pospájali bunky v workflow builderovi.

![FRINX Machine dashboard](decision_1_body.PNG)

6) **terminated**. V tomto tasku si v tabe Input parameters do kolónky Termination status vložíme "COMPLETED" (prípadne FAILED - podľa uváženia) a do poľa Expected workflow output napíšeme ľubovoľnú hlášku, napr: This device is not supported.

![FRINX Machine dashboard](terminated_1_body.PNG)

7) **Device_identification** v tabe Input parameters vložíme:
management_ip: sample-topology - toto je názov topológie v tejto instalácii, v produkcii je potrebné použiť názov topológie podľa reálneho mena.

port: `${workflow.input.port}` - ak by sme tam ručne napísali napr. 10001, pri spustení WF by sa más nič nepýtal, avšak my chceme aby pri každom spustení si užívaťeľ mohol zvoliť port, ktorý ho zaújima... To isté platí aj pre management_ip a ostatné polia. S týmto sme už pracovali v tasku lambda odsek 4)

username & password: v tomto demo príklade počítame s tým že na všetkých zariadeniach sú použité prihlasovacie údaje username: frinx, password: frinx

ako som spomínal vyššie, ak ich tam napíšeme napriamo, pri spustení sa nás na prihlasovacie údaje WF pýtať nebude, ak by sme pracovali so zariadeniami kde sú použité rôzne prihlasovacie údaje, potrebovali by sme ich vedieť meniť / zadať pri každom spustení. To by sme dosiahli podobným spôsobom, ako sme to spravili s port-om.
Vyzeralo by to nasledovne:
username -> ${workflow.input.username}
password -> ${workflow.input.password}

jednoduché. :) My sa však v tomto demo WF držíme predpokladu že všade sú rovnaké prihlasovacie údaje a tak tam môžeme napísať údaje napriamo - je to však na rozhodnutí každého.

![FRINX Machine dashboard](device_identification_1_body.PNG)

8) teraz si pridáme ďalľie bunky, v ľavom stĺpci v sekcii System tasks pridáme ďalšiu lambdu a v sekcii Workflows si nájdeme Read_journal_cli_device.
Umiestnime ich vedľa seba za Device_identification a pospájame ich. Ako je vidno na obrázku

![FRINX Machine dashboard](new_lambda_and_read_journal.PNG)

9) **druhá lambda** do lambda value napíšeme `${Device_identificationRef_f7I6.output}` - čiže v preklade "zober výstup z predošlého tasku Device_identification a s tým pracuj"

do jej tela vložíme:
```
if ($.lambdaValue.sw == 'saos') { 
  var data = $.lambdaValue.sw.toUpperCase()+$.lambdaValue.sw_version+'_1'
  return data
} else { 
  return { value: false }
}
```

preklad do ľudského jazyka čo sa vo vnútri deje je: "ak identifikované zariadenie je typu saos, z výstupnej správy predošlého tasku vyextrahuj meno (čiže saos, zmeň písmená na veľké, vyextrahuj z výstupnej správy predošlého tasku verziu zlep ich dokopy a pridaj ešte `_1` - lebo tak sú nazvané zariadenia v tejto demo topológii"

![FRINX Machine dashboard](lambda_2_body.PNG)

10) **Read_journal_cli_device** tu si v tabe Input parameters do poľa device_id vpíšeme `${lambda_ZW66.output.result}` 

![FRINX Machine dashboard](read_journal_body.PNG)

11) output z Read_journal_cli_device spojíme s END, rovnako aj OUTPUT z terminated spojíme s END a tým sme uzavreli náš custom WF.

![FRINX Machine dashboard](custom_task_final.PNG)
![FRINX Machine dashboard](custom_task_final_all.PNG)



12) uložíme a spustíme

![FRINX Machine dashboard](save_and_run.PNG)
![FRINX Machine dashboard](save_and_run_2.PNG)






## Demo “Create loopback address on devices stored in the inventory”

This workflow creates a loopback interface on all devices that are installed in the inventory or on all devices filtered by labels. Labels are marks that serves as a differentiator.

1) Check if all devices are installed. You can install them manually or by executing **Install_all_from_inventory / 1** workflow.

![FRINX Machine dashboard](devices_dashboard.png)

2) In the main page click on **Explore workflows** and in the column **Search by keyword**. type „loopback“. Workflow with name **Create_loopback_all_in_uniconfig / 1** will appear. Next click on run button under ACTIONS.

![FRINX Machine dashboard](create_loopback_all_in_uniconfig.png)

4) Insert the number 77 in **loopback_id** and press **Execute**. After executing click on the link which will appear.

![FRINX Machine dashboard](create_loopback_execute.png)

5) All tasks were executed correctly and now are completed.

![FRINX Machine dashboard](details_of_create_loopback.png)

On the results page you will see 5 individual tasks:

### INVENTORY_get_all_devices_as_dynamic_fork_tasks
This workflow displays the list of all devices in the inventory or devices filtered by label. It parses the output in the correct format for the dynamic fork, which creates a dynamic amount of tasks, depending on the number of devices in the inventory. 

### SUB_WORKFLOW
This is the dynamic fork sub-workflow. In this case, it creates UNICONFIG_write_structured_device_data for every individual device in the inventory. Thanks to this, you get detailed information on the progress and succession of every device.

### UNICONFIG_calculate_diff
This remote procedure call creates a difference between the actual UniConfig topology devices and the intended UniConfig topology nodes. 

### UNICONFIG_dryrun_commit
The remote procedure call will resolve the difference between the actual and intended configuration of devices. After all, changes are applied, the cli-dryrun journal is read and an remote procedure call output is created and returned. 

### UNICONFIG_commit
This is the final task that actually commits the intended configuration to the devices.

## Demo “L3VPN”

Before running L3VPN, run **Allocate_Root_Pool / 1** workflow and check if lab-vmx1 (device) is already installed.

![FRINX Machine dashboard](allocate_root_pool_workflow.png)

- When in the FRINX Dashboard, click on the drop-down menu in the left top corner and click on L3VPN Automation
- Click on “Services”
- Click on “+ Add service”
- Fill the information as below. VPN ID is generated automatically by clicking on “chain button”.

![FRINX Machine dashboard](create_vpn_service.png)

- Click “Save changes”
- You will be redirected to previous page.

![FRINX Machine dashboard](vpn_services.png)

- Click on “Commit changes” and in the pop-up window as well. After committing you will see all executed tasks and sub-workflows. You can click on “Go to detail” and review all the individual processes.

![FRINX Machine dashboard](l3vpn_status.png)

### Step 1.

- Return to L3VPN Automation site
- Click on “Sites”
- Look for test_site_3b9UQL4i

![FRINX Machine dashboard](sites.png)

- In the test_site_3b9UQL4i click on “Manage” and then on “Site network access”

![FRINX Machine dashboard](sites_network_accesses.png)

- Click on “Add network access”

### Step 2.

Add these settings:

**General and Service**

**VPN Attachment:** GNS00001002

**BTM Circuit Reference:** CES00000000-05

**Devices:** Pick one of the CPE devices

**SVC Input Bandwith (Mbsp):** 1000

**SVC Output Bandwith (Mbps):** 1000

![FRINX Machine dashboard](create_site_network_access.png)

**Routing Protocol:**

- click on + Create Static Protocol

**Static Routing LAN:** 10.0.0.0/8

**Static Routing Next Hop:** 10.0.0.1

**Static Routing Lan Tag:** 999

**Bgp Profiles:** 300ms

**Maximum Routes:** 2000

![FRINX Machine dashboard](routing_protocol.png)

**IP Connection**

For auto-generating provider and customer address click on:

![FRINX Machine dashboard](ico_chain.png)

**BGP Profile:** 500ms

![FRINX Machine dashboard](bgb_profile.png)

Click on **Save Changes**.

### Step 3.

Click on **Commit Changes**.

![FRINX Machine dashboard](sites_network_accesses_2.png)

Wait until all tasks are completed.

![FRINX Machine dashboard](status_l3vpn.png)
