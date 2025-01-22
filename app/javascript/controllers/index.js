// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

import CompletionToggleController from "./completion_toggle_controller"
application.register("completion-toggle", "CompletionToggleController")

eagerLoadControllersFrom("controllers", application)
