local orgmode = vim.fn.stdpath("data") .. "/lazy/orgmode"
vim.opt.runtimepath:append(orgmode)

-- Run the orgmode cron
require("orgmode").cron({
	org_agenda_files = "~/Personal/org_files/*",
	org_default_notes_file = "~/Personal/org_files/notes.org",
	notifications = {
		reminder_time = {0, 1, 5, 10 },
	},
})
