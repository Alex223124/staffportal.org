ActiveAdmin.register Week5 do
  controller do
    authorize_resource

    def active_admin_collection
      super.accessible_by current_ability
    end
  end

  actions :index, :show

  batch_action :Toggle_coach_confirm do |selection|
    week5.find(selection).each do |week5|
      week5.confirmed_coach = !week5.confirmed_coach
      week5.save
    end
    redirect_to collection_path, :notice => "Toggled selected confirmation as Coach!"
  end

  batch_action :Toggle_hr_confirm do |selection|
    week5.find(selection).each do |week5|
      week5.confirmed_hr = !week5.confirmed_hr
      week5.save
    end
    redirect_to collection_path, :notice => "Toggled selected confirmation as HR!"
  end

  menu :parent => "Bootcamp", :label => "5 Weeks Until Bootcamp"

  index :title => "5 Weeks Until Bootcamp" do |week5|
    selectable_column
    #column("Admin")   {|tasklist| tasklist.user.bootcamp_coach.username if !tasklist.user.bootcamp_coach.nil? }
    column ("Status")   {|tasklist| status_tag(tasklist.completed) }
    column :user
    column ("Assignments") {|tasklist| tasklist.assignments_remaining }
    column ("Tasks") {|tasklist| tasklist.tasks_remaining }
    column ("Coach") { |tasklist|
        if tasklist.confirmed_coach
          status_tag("CONFIRMED", "green")
        else
          status_tag("UNCONFIRMED", "orange")
        end }
    column ("HR") { |tasklist|
        if tasklist.confirmed_hr
          status_tag("CONFIRMED", "green")
        else
          status_tag("UNCONFIRMED", "orange")
        end }
    default_actions
  end

  show :title => :username do |week5|
    attributes_table do
      row ("listen_to_attitude_message") {
        if week5.listen_to_attitude_message
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("memorize_prayer_sheet_passage") {
        if week5.memorize_prayer_sheet_passage
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("prayer_sheet") {
        if week5.prayer_sheet
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("review_non_negotiables_of_effective_mpd") {
        if week5.review_non_negotiables_of_effective_mpd
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("recite_passage_from_dmpd_prayer_sheet") {
        if week5.recite_passage_from_dmpd_prayer_sheet
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("share_call_testimony") {
        if week5.share_call_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("share_salvation_testimony") {
        if week5.share_salvation_testimony
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("missionary_profile") { week5.missionary_profile.html_safe unless week5.missionary_profile.blank? }
      row ("confirmed_coach") {
        if week5.confirmed_coach
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
      row ("confirmed_hr") {
        if week5.confirmed_hr
          status_tag("COMPLETED")
        else
          status_tag("IN PROGRESS")
        end }
    end
    active_admin_comments
  end

  filter :user
  filter :created_at
  filter :updated_at
end