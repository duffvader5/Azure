maintenanceresources 
| where ['id'] contains "/subscriptions/<subscription-id>/resourcegroups/<resource-group>/providers/microsoft.compute/virtualmachines/<vm-name>" //VM Id here
| where ['type'] == "microsoft.maintenance/applyupdates" 
| where properties.maintenanceScope == "InGuestPatch"