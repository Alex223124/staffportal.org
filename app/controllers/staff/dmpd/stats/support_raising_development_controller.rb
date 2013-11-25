class Staff::Dmpd::Stats::SupportRaisingDevelopmentController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
		@late = current_user.late_support_raising_developments
		@support_raising_development = current_user.support_raising_developments
  end

	def new
		@support_raising_development = SupportRaisingDevelopment.new
		hide_weeks = [-1]
		current_user.support_raising_developments.each do |srd|
			hide_weeks << srd.week_id
		end
		@available_weeks = Week.where('id not in (?) and date_finished < ?', hide_weeks, Time.now.to_date + 1.week)
		@support_raising_development.week = @available_weeks.first
	end

	def create
		create!(:notice => "Dude! Nice job creating your weekly calling chart.") { staff_dmpd_stats_support_raising_development_index_path }
	end

	def update
		update!(:notice => "Dude! Nice job updating your weekly calling chart.") { staff_dmpd_stats_support_raising_development_index_path }
	end

  protected
    def begin_of_association_chain
      current_user
    end
end