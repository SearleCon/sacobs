window.Views.Bookings ||= {}
window.Views.Bookings.Archives ||= {}
class Views.Bookings.Archives.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
