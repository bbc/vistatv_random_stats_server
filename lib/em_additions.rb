module EventMachine
  # Most periodic tasks need to be run both now and after a specificed time
  # period. This Eventmachine helper does that. You can specify the timeframe
  # in hours, minutes or seconds.
  #
  def self.now_and_every(period, &blk)
    next_tick do
      yield
    end

    seconds = Float(period) rescue nil

    seconds ||= case
      when period.include?(:hours)
        period[:hours]*60*60
      when period.include?(:minutes)
        period[:minutes]*60
      else
        period[:seconds]
    end

    add_periodic_timer(seconds) do
      yield
    end
  end
end
