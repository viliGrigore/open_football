class BulkUploadJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    added_records = 0
    existent_records = 0

    (1..csv_file.count - 1).each do |csv_line|
      team_name = csv_file[csv_line][0]
      manager_first_name = csv_file[csv_line][1]
      manager_last_name = csv_file[csv_line][2]
      manager_age = csv_file[csv_line][3]
      team = Team.create(name: team_name)
      manager = Manager.create(first_name: manager_first_name,
                               last_name:  manager_last_name,
                               age:        manager_age,
                               team_id:    team.id)

      if team.save
        added_records += 1
      else
        existent_records += 1
      end
    end
    TeamMailer.send_report(added_records, existent_records).deliver_later
  end
end
