Teacup::Stylesheet.new(:timer_view) do
  style :root,
    landscape: false

  style :state,
    left: 20,
    top: 200,
    width: 280,
    height: 40,
    text: 'Tap to Start',
    textAlignment: UITextAlignmentCenter,
    textColor: 'white'.to_color,
    backgroundColor: UIColor.clearColor,
    font: UIFont.systemFontOfSize(30)

  style :button,
    left: 20,
    top: 260,
    width: 280,
    height: 40
end

class TimerController < UIViewController
  stylesheet :timer_view

  layout :root do
    @state = subview(UILabel, :state)
    @button = subview(UIButton.buttonWithType(UIButtonTypeRoundedRect), :button)
    @button.setTitle('Start', forState:UIControlStateNormal)
    @button.setTitle('Stop', forState:UIControlStateSelected)
  end

  def viewDidLoad
    super

    @button.when(UIControlEventTouchUpInside) do
      if @timer
        EM.cancel_timer(@timer)
        @timer = nil
      else
        @duration = 0
        @timer = EM.add_periodic_timer 0.1 do
          @state.text = "%.1f" % (@duration += 0.1)
        end
      end
      @button.selected = !@button.selected?      
    end
    
    view.addSubview(@button)
  end
end
