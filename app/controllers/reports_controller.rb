class ReportsController < ApplicationController
  before_action :set_report, except: [:index, :new, :create]
  before_action :set_results, except: [:index, :new, :create]

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.create(report_params)
    respond_with @report, location: reports_url
  end

  def edit
  end

  def update
    @report.update(report_params)
    respond_with @report
  end

  def show
    @results = Booking.processed.where(created_at: @report.period_from..@report.period_to).search(@report.criteria).result
  end

  def download
    pdf = WickedPdf.new.pdf_from_string(render_to_string(template: 'reports/_results.html.haml', layout: 'pdf.html'))
    send_data(pdf,
              filename: "#{@report.name}_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
              disposition: :attachment)
  end

  def print
    respond_to do |format|
      format.pdf do
        render pdf: "#{@report.name}_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
               template: 'reports/_results.html.haml',
               disposition: :inline,
               layout: 'pdf.html'
      end
    end
  end

  def destroy
    @report.destroy
    respond_with @report
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def set_results
    @results = Booking.processed.search(@report.criteria).result.where(created_at: @report.period.months.ago.beginning_of_month..Date.today.end_of_month)
  end

  def report_params
    params.fetch(:report, {}).permit(:name, :period_from, :period_to, criteria: [:stop_connection_from_city_id_eq, :stop_connection_to_city_id_eq, status_eq_any: [], passengers_passenger_type_id_eq_any: []])
  end
end
