module OrdersHelper
  def state_badge(state)
    case state
    when 0
      raw("<span class='badge badge-secondary'>Waiting for delivery</span>")
    when 1
      raw("<span class='badge badge-warning'>Waiting for Receiving</span>")
    when 2
      raw("<span class='badge badge-success'>Finished</span>")
    else
      raw("<span class='badge badge-danger'>Unknown</span>")
    end
  end
end
