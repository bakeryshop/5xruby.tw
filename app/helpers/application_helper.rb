module ApplicationHelper
  def notice_message
    # <div class="alert alert-warning alert-dismissable">
    #   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    #   <strong>Warning!</strong> Better check yourself, you're not looking too good.
    # </div>
    ret = ''.html_safe
    %i[alert notice].each do |alert_type|
      if flash[alert_type]
        alert_class = case alert_type
                      when :alert then 'alert-danger'
                      when :notice then 'alert-success'
                      end
        ret += content_tag :div, class: "alert #{alert_class} alert-dismissable", style: 'margin-bottom: 0px' do
                concat button_tag('×', class: 'close', data: {dismiss: :alert, hidden: true})
                concat flash[alert_type]
               end
      end
    end
    ret
    #ret = ''.html_safe
    #ret += content_tag :div, alert, class: 'alert alert-danger' if alert
    #ret += content_tag :div, notice, class: 'alert alert-success' if notice
    #ret
  end

  def has_error_class record, attribute
    'has-error' if record.errors[attribute].present?
  end

  def help_block record, attribute
    @contact.errors.messages[attribute].map do |msg|
      content_tag :p, msg, class: 'help-block'
    end.join.html_safe if record.errors[attribute].present?
  end
end
