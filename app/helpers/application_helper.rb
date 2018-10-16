module ApplicationHelper

  def client_device(device)
    case device
    when 'pc'
      '桌機'
    when 'rweb'
      '手機/app'
    end
  end
end
