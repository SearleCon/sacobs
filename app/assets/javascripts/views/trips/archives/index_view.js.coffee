window.Views.Trips ||= {}
window.Views.Trips.Archives ||= {}
class Views.Trips.Archives.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
