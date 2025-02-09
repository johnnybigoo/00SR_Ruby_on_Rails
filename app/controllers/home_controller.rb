class HomeController < ApplicationController
  def index
    current_time = Time.current
    @current_date    = current_time.strftime("%A, %b %d")
    @formatted_time  = current_time.strftime("%I:%M %p")
    @user_name       = "Richard Harrison"
    @greeting        = get_greeting(current_time)
  end

  private

  def get_greeting(time)
    # Determine the period ("AM" or "PM")
    period = time.strftime("%p")

    if period == "AM"
      # For very early AM hours (e.g., midnight to 4:59 AM) you might wish to greet as "Good night"
      if time.hour < 5
        "Good night"
      else
        "Good morning"
      end
    else
      # PM
      if time.hour < 17
        "Good afternoon"
      elsif time.hour < 21
        "Good evening"
      else
        "Good night"
      end
    end
  end
end