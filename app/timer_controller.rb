class TimerController < UIViewController
  def viewDidLoad
    margin = 20

    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(30)
    @state.text = 'Tap to start'
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.whiteColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle('Start', forState:UIControlStateNormal)
    @button.setTitle('Stop', forState:UIControlStateSelected)
    @button.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]

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
