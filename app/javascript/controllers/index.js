// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// These should be auto-loaded, remove manual registration to avoid conflicts
// import WizardController from "./wizard_controller"
// import PurposeFieldsController from "./purpose_fields_controller"
// application.register("wizard", WizardController)
// application.register("purpose-fields", PurposeFieldsController)

import { Alert, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('toggle', Toggle)
application.register('slideover', Slideover)
