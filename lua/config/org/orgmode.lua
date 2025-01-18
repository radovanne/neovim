require("orgmode").setup({
  org_agenda_files = { "~/Personal/org_files/*" },
  org_default_notes_file = "~/Personal/org_files/notes.org",
  notifications = {
    enabled = true,
    cron_enabled = true,
    repeater_reminder_time = false,
    deadline_warning_reminder_time = false,
    reminder_time = 10,
    deadline_reminder = true,
    scheduled_reminder = true,
    notifier = function(tasks)
      local result = {}
      for _, task in ipairs(tasks) do
        require("orgmode.utils").concat(result, {
          string.format("# %s (%s)", task.category, task.humanized_duration),
          string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title),
          string.format("%s: <%s>", task.type, task.time:to_string()),
        })
      end

      if not vim.tbl_isempty(result) then
        print("NEOVIM NOTIFIER")
        require("orgmode.notifications.notification_popup"):new({ content = result })
      end
    end,
    cron_notifier = function(tasks)
      for _, task in ipairs(tasks) do
        local title = string.format("%s (%s)", task.category, task.humanized_duration)
        local subtitle = string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title)
        local date = string.format("%s: %s", task.type, task.time:to_string())

        -- Linux
        if vim.fn.executable("notify-send") == 1 then
          print("SYSTEM NOTIFIER")
          vim.loop.spawn("notify-send", { args = { string.format("%s\n%s\n%s", title, subtitle, date) } })
        end

        -- MacOS
        if vim.fn.executable("terminal-notifier") == 1 then
          vim.loop.spawn(
            "terminal-notifier",
            { args = { "-title", title, "-subtitle", subtitle, "-message", date } }
          )
        end
      end
    end,
  },
})
