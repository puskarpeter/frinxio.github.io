# Install all devices from inventory

Once you add multiple devices to your inventory, it can get tedious to install all of them individually. To make things easier, we built a workflow that will install all
devices present in the inventory. To use this workflow, follow these instructions:

On landing page go to `Workflow Manager` section, click `Explore` button and search for the workflow called **Install_all_from_inventory**.

![Search for install_all_from_inventory](install_all_from_inventory_search.png)

After searching, click the `Execute` button (blue play icon). A window will appear where you can enter the input parameter. This workflow does not require any input if you want to install all uninstalled devices. If you specified a device label while adding devices, you can use it to determine which devices should be bulk installed. So just click "Execute" again.

![Execute install_all_from_inventory](install_all_from_inventory_pop_up_window.png)

Once you execute, numeric link will appear left to the `Execute` button. It will take you to a page where you can see individual tasks of this workflow, its inputs/output and wheter it was successful or unsuccessful. In the "Input/Output" tab you can see both the devices that were installed as a result of this workflow and those that were already installed.

![Results of the workflow](install_all_from_inventory_result.png)